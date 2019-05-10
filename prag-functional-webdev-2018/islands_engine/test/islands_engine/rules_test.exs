defmodule IslandsEngine.RulesTest do
  alias IslandsEngine.Rules

  use ExUnit.Case

  describe "the :initialized state" do
    setup do
      rules = Rules.new()
      {:ok, rules: rules}
    end

    test "transitions to :players_set for the :add_player event", %{
      rules: rules
    } do
      {:ok, rules} = Rules.check(rules, :add_player)

      assert rules.state == :players_set
    end

    test "does not transition for other events", %{rules: rules} do
      assert :error == Rules.check(rules, :other_event)
      assert rules.state == :initialized
    end
  end

  describe "the :players_set state" do
    setup do
      rules = Rules.new()
      rules = %Rules{rules | state: :players_set}

      {:ok, rules: rules}
    end

    test "maintains state for the :position_islands event", %{rules: rules} do
      {:ok, rules} = Rules.check(rules, {:position_islands, :player1})
      {:ok, rules} = Rules.check(rules, {:position_islands, :player2})

      assert rules.state == :players_set
    end

    # test

    test "maintains state for the same player emitting multiple :set_islands events",
         %{
           rules: rules
         } do
      {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
      {:ok, rules} = Rules.check(rules, {:set_islands, :player1})

      assert rules.state == :players_set
    end
  end
end
