defmodule SendToSocket do

# ./websocketd -port=8080 ./send_env.sh
#  start_agent="mix run -e SendToSocket.start_link"
#$start_agent

  def one_off do
    {:ok, body} = File.read "queue"
    IO.inspect(body == "")
  end

  def loop do
    file_name = "queue"
    case File.exists?(file_name) do
      true -> print_contents(file_name)
      false -> :timer.sleep(1500)
    end
    :timer.sleep(500)
    loop()
  end

  def print_contents(file_name) do
    {:ok, body} = File.read "queue"
    if body != "" do
      IO.inspect(body)
      case File.exists?(file_name) do
        true -> File.rm(file_name)
        false -> :timer.sleep(100)
      end
    end
  end

end
