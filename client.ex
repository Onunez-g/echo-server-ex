defmodule C do
  def connect(port) do
    opts = [:binary, active: false, packet: :line]
    {:ok, socket} = :gen_tcp.connect('127.0.0.1', port, opts)

    loop(socket)
  end
  defp loop(socket) do
    data = IO.gets("Write something: ")
    write_line(data, socket)
    response = read_line(socket)
    IO.puts "answer: #{response}"
    loop(socket)
  end
  defp read_line(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    data
  end
  defp write_line(line, socket) do
    :gen_tcp.send(socket, line)
  end
end