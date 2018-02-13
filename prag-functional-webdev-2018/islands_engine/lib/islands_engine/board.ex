defmodule IslandsEngine.Board do
  @moduledoc """
  The player's board contains their islands and it also brokers messages for
  them. There should be no duplicate island types.

  """

  @doc """
  Convenience function to keep boards consistent with the rest of our domain
  entities.
  """
  def new(), do: %{}
end
