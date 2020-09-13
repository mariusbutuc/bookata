defmodule Servy.Handler do
  @moduledoc """
  Handle a request by transforming it into a response.

  ## Ubiquitous Language
    * `conv` represents the "conversation" between the browser and our server.
  """

  @doc """
  Return a response by applying a series of transformations to a request.
  """
  def handle(request) do
    request
    |> parse()
    |> route()
    |> format_response()
  end

  @doc """
  Transform the request string into a map.
  """
  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split()

    %{method: method, path: path, resp_body: ""}
  end

  @doc """
  Transform the `conv` map into a new map that also has a response body.
  """
  def route(conv), do: %{conv | resp_body: "Bears, Lions, Tigers"}

  @doc """
  Transform the `conv` map into a valid HTTP response string.
  """
  def format_response(%{resp_body: resp_body} = _conv) do
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: #{byte_size(resp_body)}

    #{resp_body}
    """
  end
end
