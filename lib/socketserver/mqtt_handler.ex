defmodule MqttHandler do
  @moduledoc false

  require Logger

  use Tortoise.Handler

  defstruct []
  alias __MODULE__, as: State

  def init(opts) do
#    Logger.info("Initializing handler")
    {:ok, %{id: List.last(opts).id, pid: List.last(opts).pid}}
  end

  def connection(:up, state) do
#    Logger.info("Connection has been established")
    {:ok, state}
  end

  def connection(:down, state) do
    Logger.warn("Connection has been dropped")
    {:ok, state}
  end

  def connection(:terminating, state) do
    Logger.warn("Connection is terminating")
    {:ok, state}
  end

  def subscription(:up, topic, state) do
#    Logger.info("Subscribed to #{topic}")
    {:ok, state}
  end

  def subscription({:warn, [requested: req, accepted: qos]}, topic, state) do
    Logger.warn("Subscribed to #{topic}; requested #{req} but got accepted with QoS #{qos}")
    {:ok, state}
  end

  def subscription({:error, reason}, topic, state) do
    Logger.error("Error subscribing to #{topic}; #{inspect(reason)}")
    {:ok, state}
  end

  def subscription(:down, topic, state) do
#    Logger.info("Unsubscribed from #{topic}")
    {:ok, state}
  end

  def handle_message(topic, publish, state) do
    Socketserver.Worker.add_to_queue(state.pid, state.id)
#    Logger.info("#{state.id} - #{Enum.join(topic, "/")} #{inspect(publish)}")
    {:ok, state}
  end

  def terminate(reason, _state) do
    Logger.warn("Client has been terminated with reason: #{inspect(reason)}")
    :ok
  end
end
