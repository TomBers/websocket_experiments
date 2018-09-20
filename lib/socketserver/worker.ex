defmodule Socketserver.Worker do
  use GenServer

  def start_link do
    IO.inspect("Started Genserver")
    {:ok, pid} = GenServer.start_link(__MODULE__, :ok, name: :wsq)
  end

  def read_queue(pid) do
    GenServer.call(pid, {:read})
  end

  def add_to_queue(pid, item) do
    GenServer.cast(pid, {:add, item})
  end

  # Server Callbacks

  def init(:ok) do
    {:ok, []}
  end

  def handle_call({:read}, from, list) do
    {:reply, list, list}
  end

  def handle_cast({:add, item}, list) do
    {:noreply, list ++ [item]}
  end

end
