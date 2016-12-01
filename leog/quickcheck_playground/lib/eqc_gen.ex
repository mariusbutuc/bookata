defmodule EQCGen do
  use EQC.ExUnit

  def string_with_fixed_length do
    let len <- choose(1, 10) do
      vector(len, frequency([
        {3, oneof(:lists.seq(?a, ?z))}, # 75% chance to generate letters
        {1, ?,}                         # 25% of the time commas
      ]))
    end
  end
end
