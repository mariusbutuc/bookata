defmodule StringEQC do
  use ExUnit.Case
  use EQC.ExUnit

  property "splitting a string with a delimiter and joining it again yields the same string" do
    forall s <- EQCGen.string_with_fixed_length do
      expected = to_string(s)

      actual =
        expected
        |> String.split(",")
        |> join(",")

      :eqc.classify(
        String.contains?(expected, ","),
        :string_with_commas,
        ensure expected == actual
      )
    end
  end

  defp join(parts, delimiter) do
    parts
    |> Enum.intersperse([delimiter])
    |> Enum.join
  end
end
