defmodule Procs do
  def hello(name) do
    Process.sleep(5_000)
    IO.puts("Hello #{name}")
  end
end
