defmodule Servy.Plugins do
  @moduledoc """
  General use plugin functions.
  """

  require Logger

  @doc """
  Rewrite (re-route?) paths to make them prettier or to juice up a page's SEO.
  """
  def rewrite_path(%{path: "/wildlife"} = conv) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path(%{path: path} = conv) do
    regex = ~r{\/(?<entity>\w+)\?id=(?<id>\d+)}
    captures = Regex.named_captures(regex, path)
    rewrite_path_captures(conv, captures)
  end

  def rewrite_path(conv), do: conv

  # TODO Intentional about keeping these private function clauses close to the
  # call site. For now.
  defp rewrite_path_captures(conv, %{"entity" => entity, "id" => id}) do
    %{conv | path: "/#{entity}/#{id}"}
  end

  defp rewrite_path_captures(conv, nil), do: conv

  @doc "Logs 404 requests."
  def track(%{status: 404, path: path} = conv) do
    Logger.warn("#{path} is on the loose!")
    conv
  end

  def track(conv), do: conv
end
