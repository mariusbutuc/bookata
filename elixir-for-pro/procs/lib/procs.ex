defmodule Procs do
  def greeter(what_to_say) when what_to_say |> is_binary() do
    receive do
      msg ->
        IO.puts("#{what_to_say}: #{inspect(msg)}")
    end

    # Tail recursion is memory efficient
    greeter(what_to_say)
  end
end
