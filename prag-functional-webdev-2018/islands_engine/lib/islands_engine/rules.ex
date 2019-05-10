defmodule IslandsEngine.Rules do
  @moduledoc """
  Handle state with a purely functional state machine.

  Use a data structure and multiple clauses of a single function to make
  decisions and enforce rules in an application. Keep the code clean by
  separating state management from business logic. This is as an alternative to
  using OTP's `:gen_statem` to implement our state machine.

  A state machine defines:
    * a finite number of _states_ that a system can be in (stages an application
      can go through)
    * any _events_ in the system that can trigger transitions between those
      states

  ┌───────────┐  ┌───────────┐  ┌────────────┐   ┌────────────┐  ┌─────────┐
  │initialized│─>│players_set│─>│player1_turn│<─>│player2_turn│─>│game_over│
  └───────────┘  └───────────┘  └────────────┘   └────────────┘  └─────────┘
                                          │                         ^
                                          └─────────────────────────┘
  """

  alias __MODULE__

  defstruct state: :initialized,
            player1: :islands_not_set,
            player2: :islands_not_set

  def new, do: %Rules{}

  @doc """
  For a given state and event, decide whether or not to
    * permit this combination of state/event
    * transition to a new state
  """
  def check(state, action)

  def check(_state, _action), do: :error
end
