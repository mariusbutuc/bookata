defmodule HitCount do
  @moduledoc """
  Keeps count of website visits using an agent.any()

  The use of an agent is an _implementation_ detail. It should never leak into the rest of your code.
  """

  def start() do
    Agent.start_link(fn -> 0 end)
  end

  def record_hit(agent) do
    Agent.update(agent, &(&1 + 1))
  end

  def get_count(agent) do
    Agent.get(agent, & &1)
  end
end
