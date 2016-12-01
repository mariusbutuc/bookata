defmodule MiscelaneousEQC do
  use ExUnit.Case
  use EQC.ExUnit

  property "encoding is the inverse of decoding" do
    forall bin <- binary do
      expected = bin

      actual =
        expected
        |> Base.encode64
        |> Base.decode64!

      ensure expected == actual
    end
  end
end
