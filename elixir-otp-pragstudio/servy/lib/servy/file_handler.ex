defmodule Servy.FileHandler do
  @moduledoc """
  Handles files.
  """

  require Logger

  def handle_file({:ok, content}, conv) do
    %{conv | status: 200, resp_body: content}
  end
  def handle_file({:error, :enoent}, conv) do
    %{conv | status: 404, resp_body: "File not found!"}
  end
  def handle_file({:error, reason}, conv) do
    Logger.warn("File error: #{reason}")
    %{conv | status: 500, resp_body: "File error: #{reason}"}
  end
end
