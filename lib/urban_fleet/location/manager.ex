defmodule LocationManager do

 alias LocationStorage

 def valid_location?(location) when is_binary(location) do
   locations = LocationStorage.load_locations()
   if Enum.any?(locations, fn loc -> String.downcase(loc) == String.downcase(location) end) do
    true
  else
    IO.puts("Ubicación no válida: #{location}")
    false
  end
 end

 def list_locations do
    locations = LocationStorage.load_locations()

    if locations == [] do
      IO.puts("No hay ubicaciones registradas.")
    else
      IO.puts("Ubicaciones disponibles:")
      Enum.each(locations, &IO.puts(" - " <> &1))
    end
  end

end
