defmodule TextClient.Impl.MarkupTest do
  use ExUnit.Case
  alias TextClient.Impl.Markup
  doctest Markup

  test "does not support full CSS hex codes yet" do
    assert_raise FunctionClauseError, fn ->
      Markup.color("#FF0000")
    end
  end
end
