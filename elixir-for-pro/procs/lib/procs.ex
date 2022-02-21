defmodule Procs do
  def greeter(count) when count |> is_number() do
    receive do
      {:quit} ->
        IO.puts("I'm outta here!")

      {:reset} ->
        greeter(0)

      {:add, n} ->
        greeter(count + n)

      msg ->
        IO.puts("#{count}: Hello #{inspect(msg)}")

        # Remember: function acting as a loop
        #           Tail recursion
        #           Memory efficient
        greeter(count)
    end
  end
end
