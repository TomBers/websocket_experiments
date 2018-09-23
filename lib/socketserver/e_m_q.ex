defmodule EMQ do

  def sub_emq do
    Tortoise.Supervisor.start_child(
      client_id: "emq",
      handler: {Tortoise.Handler.Logger, []},
      server: {Tortoise.Transport.Tcp, host: '18.130.103.115', port: 1883},
      subscriptions: [{"topic/test", 0}])
  end

  def pub do
    Tortoise.publish("emq", "topic/test", "From elixir", qos: 0)
  end
  def pub_msg do
    1..5
    |> Enum.each(fn(msg) -> Tortoise.publish("emq", "topic/test", "#{msg}", qos: 0); :timer.sleep(500) end)
  end

end
