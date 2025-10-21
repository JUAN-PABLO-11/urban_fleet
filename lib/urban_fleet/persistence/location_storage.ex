defmodule LocationStorage do
  @ruta "data/locations.dat"

  def load_locations do
    if File.exists?(@ruta) do
      @ruta
      |> File.read!()
      |> String.split("\n", trim: true)
    else
      []
    end
  end

  def save_locations(locations) when is_list(locations) do
    content = Enum.join(locations, "\n")
    File.write(@ruta, content)
  end
  
end
