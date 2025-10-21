defmodule User do
  @moduledoc """
  Representa a un usuario del sistema con su información básica y rol asignado.
  """
  defstruct [:id,:name,:role, :password_hash, :score]
end
