defmodule UserManager do
  @moduledoc """
  Maneja el registro, autenticación y carga/guardado de usuarios en el sistema.
  """

  alias UserStorage
  alias User

  @doc """
  Crea y guarda un nuevo usuario si el nombre no existe.
  """
  def register_user(name, role, password) do
    users = UserStorage.load_users()

    case Enum.find(users, &(&1.name == name)) do
      nil ->
        new_user = %User{
          id: generate_id(),
          name: name,
          role: role,
          password_hash: hash_password(password),
          score: 0
        }

        UserStorage.save_users(users ++ [new_user])
        {:ok, new_user}

      _existing ->
        {:error, :usuario_ya_existente}
    end
  end

  @doc """
  Inicia sesión verificando el nombre y la contraseña de un usuario.
  """
  def login(name, password) do
    users = UserStorage.load_users()

    case Enum.find(users, &(&1.name == name)) do
      nil ->
        {:error, :usuario_no_encontrado}

      user ->
        if verificar_password(user, password),
          do: {:ok, user},
          else: {:error, :contraseña_incorrecta}
    end
  end

  def get_score_by_id(id) do
    users = UserStorage.load_users()

    case Enum.find(users, &(&1.id == id)) do
      nil -> {:error, :usuario_no_encontrado}
      user -> {:ok, user.score}
    end
  end

  def ranking do
    users = UserStorage.load_users()

    users
    |> Enum.group_by(& &1.role)
    |> Enum.map(fn {role, users_in_role} ->
      {
        role,
        Enum.sort_by(users_in_role, & &1.score, :desc)
      }
    end)
  end

  defp generate_id, do: :erlang.unique_integer([:positive])

  defp hash_password(password),
    do: :crypto.hash(:sha256, password) |> Base.encode16()

  defp verificar_password(user, password),
    do: hash_password(password) == user.password_hash
end
