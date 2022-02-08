defmodule Hamgman.Type do
  @moduledoc """
  Public interface types
  """

  @typedoc """
  The state† that a game can be in at any given time.

  †I'm thinking "state machine" type of "state" here.
  """
  @type state ::
          :initializing
          | :won
          | :lost
          | :good_guess
          | :bad_guess
          | :already_used

  @typedoc """
  Public (client-side) value representing game state, e.g., current score etc.
  """
  @type tally :: %{
          turns_left: integer,
          game_state: state,
          letters: list(String.t()),
          used: list(String.t())
        }
end
