defmodule MQTT do
  use GenServer

  def start_link do
    IO.inspect("MQTT")

    Tortoise.Supervisor.start_child(
      client_id: "my_client_id",
      handler: {Tortoise.Handler.Logger, []},
      server: {Tortoise.Transport.Tcp, host: 'localhost', port: 1883},
      subscriptions: [{"topic/test", 0}])

    Tortoise.publish("my_client_id", "topic/test", "Hello from the World of Tomorrow !", qos: 0)

    {:ok, pid} = GenServer.start_link(__MODULE__, :ok, name: :mqtt)
  end

  def init(:ok) do
    {:ok, []}
  end

  def pub(val) do
    Tortoise.publish("my_client_id", "topic/test", "#{val}", qos: 0)
  end

end
