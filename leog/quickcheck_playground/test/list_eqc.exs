defmodule ListEQC do
  use ExUnit.Case
  use EQC.ExUnit

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
end
