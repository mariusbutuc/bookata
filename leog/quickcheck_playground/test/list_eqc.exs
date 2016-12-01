defmodule ListEQC do
  use ExUnit.Case
  use EQC.ExUnit

  property "Erlang sequence" do
    forall {m, n} <- {int, int} do
      implies n >= m do
        ensure Enum.to_list(m .. n) == :lists.seq(m, n)
      end
    end
  end

  property "reversing a list twice yields the original list" do
    forall l <- list(int) do
      expected = l

      actual =
        expected
        |> Enum.reverse
        |> Enum.reverse

      ensure expected == actual
    end
  end

  property "sorting works" do
    forall l <- list(int) do
      ensure l |> Enum.sort |> is_sorted == true
    end
  end

  defp is_sorted([]), do: true
  defp is_sorted(list) do
    list
    |> Enum.zip(tl(list))
    |> Enum.all?(fn {x, y} -> x <= y end)
  end
end
