defmodule ResultLogger do
  @ruta "data/results.log"

  @doc """
  Guarda un registro de viaje en el historial.
  """
  def log_trip(%{fecha: fecha, cliente: cliente, conductor: conductor, origen: origen, destino: destino, estado: estado}) do
    linea = Enum.join([fecha, cliente, conductor, origen, destino, estado], ";") <> "\n"
    File.write!(@ruta, linea, [:append])
  end
end
