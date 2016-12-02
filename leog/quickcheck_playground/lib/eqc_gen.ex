defmodule EQCGen do
  use EQC.ExUnit

  def nested_list(generator) do
    sized size do
      nested_list(size, generator)
    end
  end

  defp nested_list(0, _generator) do
    []
  end
  defp nested_list(size, generator) do
    lazy do
      oneof [
        [generator | nested_list(size-1, generator)],
        [nested_list(size-1, generator)]
      ]
    end
  end

  def string_with_fixed_length do
    let len <- choose(1, 10) do
      vector(len, frequency([
        {3, oneof(:lists.seq(?a, ?z))}, # 75% chance to generate letters
        {1, ?,}                         # 25% of the time commas
      ]))
    end
  end
end
