defmodule MQTT_clients do

  def run do
    pid = Process.whereis(:wsq)
    Enum.each(1..5, fn(x) -> kick_off_10_connections(pid, 1883, x) end)
    System.cmd("/usr/local/Cellar/mosquitto/1.5.1/bin/mosquitto_pub", ["-t","topic/test", "-m", "MSG"])
    :timer.sleep(1000)
    length(Socketserver.Worker.read_queue(pid))
  end

  def kick_off_10_connections(pid, port, id) do
    Enum.each(1..10, fn(num) -> spwn_sub(pid, port, "#{id}_#{num}") end)
    :timer.sleep(200)
  end

  def spwn_sub(pid, port, id) do
    spawn fn -> subscribe(pid, port, id) end
  end


  def subscribe(pid, port, id) do
    uid = "#{port}_#{id}"
    Tortoise.Supervisor.start_child(
      client_id: "my_client_#{uid}",
      handler: {MqttHandler, [%{pid: pid, id: uid}]},
      server: {Tortoise.Transport.Tcp, host: 'localhost', port: port},
      subscriptions: [{"topic/test", 0}])
  end

  def scale do
    1883..1892
    |> Enum.each(fn(port) -> subscribe_and_publish(port) end)

    :timer.sleep(1000)
    pid = Process.whereis(:wsq)
    length(Socketserver.Worker.read_queue(pid))
  end

  def subscribe_and_publish(port) do
    pid = Process.whereis(:wsq)
    Enum.each(1..2, fn(x) -> subscribe(pid, port, x) end)
    :timer.sleep(1000)
#    System.cmd("/usr/local/Cellar/mosquitto/1.5.1/bin/mosquitto_pub", ["-p", "#{port}", "-t","topic/test", "-m", "MSG"])
  end


end
