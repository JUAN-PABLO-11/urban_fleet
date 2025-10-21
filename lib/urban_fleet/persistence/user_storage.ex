defmodule UserStorage do
  @moduledoc """
  Módulo encargado de leer y escribir usuarios en el archivo `data/users.dat`.

  Formato de cada línea: id|nombre|rol|password_hash|puntaje
  """

  @ruta "data/users.dat"

  @doc """
  Guarda una lista de usuarios en el archivo `users.dat`.
  Cada usuario se escribe en una línea con formato: id|nombre|rol|password_hash|puntaje
  """
  def save_users(users) when is_list(users) do
    content =
      Enum.map(users, fn u ->
        "#{u.id}|#{u.name}|#{u.role}|#{u.password_hash}|#{u.score}"
      end)
      |> Enum.join("\n")

    File.write!(@ruta, content)
  end

  @doc """
  Carga todos los usuarios desde el archivo `users.dat` y los convierte en structs.
  Si el archivo no existe, devuelve una lista vacía.
  """
  def load_users do
    if File.exists?(@ruta) do
      @ruta
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_usuario/1)
    else
      []
    end
  end

  defp parse_usuario(line) do
    [id_str, name, role_str, password_hash, score_str] = String.split(line, "|")

    %User{
      id: String.to_integer(id_str),
      name: name,
      role: String.to_atom(role_str),
      password_hash: password_hash,
      score: String.to_integer(score_str)
    }
  end
end
