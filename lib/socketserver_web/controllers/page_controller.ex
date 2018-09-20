defmodule SocketserverWeb.PageController do
  use SocketserverWeb, :controller

  def index(conn, _params) do
    MQTT.pub(Enum.random(1..20))
    render conn, "index.html"
  end

  def print(conn, %{"val" => value}) do
    IO.inspect(value)
#    pid = Process.whereis(:wsq)
#    Socketserver.Worker.add_to_queue(pid, Enum.random(1..10))
    {:ok, file} = File.open "queue", [:write]
    IO.binwrite file, value
    File.close file
    render conn, "print.html"
  end
end
