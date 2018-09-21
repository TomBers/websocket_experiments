defmodule MQTT_clients do

  def run do
    Enum.each(1..1000, fn(x) -> subscribe(x) end)
    :timer.sleep(2000)
    System.cmd("/usr/local/Cellar/mosquitto/1.5.1/bin/mosquitto_pub", ["-t","topic/test", "-m", "MSG"])
    :timer.sleep(1000)
    pid = Process.whereis(:wsq)
    length(Socketserver.Worker.read_queue(pid))
  end

  def subscribe(id) do
    :timer.sleep(100)
    Tortoise.Supervisor.start_child(
      client_id: "my_client_#{id}",
      handler: {MqttHandler, [id]},
      server: {Tortoise.Transport.Tcp, host: 'localhost', port: 1883},
      subscriptions: [{"topic/test", 0}])
  end

end
