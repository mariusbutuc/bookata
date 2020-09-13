defmodule Servy.Handler do
  @moduledoc """
  Handle a request by transforming it into a response.

  ## Ubiquitous Language
    * `conv` represents the "conversation" between the browser and our server.
  """

  require Logger

  @doc """
  Return a response by applying a series of transformations to a request.
  """
  def handle(request) do
    request
    |> parse()
    |> rewrite_path()
    |> route()
    |> track()
    |> emojify()
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

    %{
      method: method,
      path: path,
      resp_body: "",
      status: nil
    }
  end

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

  @doc """
  Add the response body and status code to the `conv` map.
  """
  def route(%{method: "GET", path: "/wildthings"} = conv), do:
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  def route(%{method: "GET", path: "/bears"} = conv), do:
    %{conv | status: 200, resp_body: "Teddy, Smokey, Paddington"}
  def route(%{method: "GET", path: "/bears/" <> id} = conv), do:
    %{conv | status: 200, resp_body: "Bear #{id}"}
  def route(%{method: "DELETE", path: "/bears/" <> _id} = conv), do:
    %{conv | status: 403, resp_body: "Bears can never be deleted!"}
  def route(%{path: path} = conv), do:
    %{conv | status: 404, resp_body: "No #{path} here!"}

  @doc """
  Track the missing path every time a 404 is returned.
  """
  def track(%{status: 404, path: path} = conv) do
    Logger.warn("#{path} is on the loose!")
    conv
  end

  def track(conv), do: conv

  @doc """
  Decorate all responses that have a 200 status with emojies before and after
  the actual content.
  """
  def emojify(%{status: 200, resp_body: resp_body} = conv) do
    # TODO Starting to forget what does a `conv` contain. Wishing for Structs,
    # @types, and @ specs.
    %{conv | resp_body: "🍌 #{resp_body} 🙈🙉🙊"}
  end

  def emojify(conv), do: conv

  @doc """
  Transform the `conv` map into a valid HTTP response string.
  """
  def format_response(%{resp_body: resp_body, status: status} = _conv) do
    """
    HTTP/1.1 #{status} #{status_reason(status)}
    Content-Type: text/html
    Content-Length: #{byte_size(resp_body)}

    #{resp_body}
    """
  end

  defp status_reason(code) do
    codes = %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }

    codes[code]
  end
end
