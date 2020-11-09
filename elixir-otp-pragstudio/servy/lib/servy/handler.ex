defmodule Servy.Handler do
  @moduledoc """
  Handles HTTP requests.

  ## Ubiquitous Language
    * `conv` represents the "conversation" between the browser and our server.
  """

  alias Servy.Conv

  import Servy.FileHandler, only: [handle_file: 2]
  import Servy.Parser, only: [parse: 1]
  import Servy.Plugins, only: [rewrite_path: 1, track: 1]

  require Logger

  @pages_path Path.expand("pages", File.cwd!())

  @doc "Transforms a request into a response."
  def handle(request) do
    request
    |> parse()
    |> rewrite_path()
    |> route()
    |> track()
    |> format_response()
  end

  @doc """
  Add the response body and status code to the `conv` map.
  """
  def route(%Conv{method: "GET", path: "/wildthings"} = conv),
    do: %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}

  def route(%Conv{method: "GET", path: "/bears"} = conv),
    do: %{conv | status: 200, resp_body: "Teddy, Smokey, Paddington"}

  def route(%Conv{method: "GET", path: "/bears/new"} = conv) do
    # TODO Revisit semantic duplication relative to
    #      route(%Conv{method: "GET", path: "/pages/" <> static_page_slug} = conv)
    @pages_path
    |> Path.join("form.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{method: "GET", path: "/bears/" <> id} = conv),
    do: %{conv | status: 200, resp_body: "Bear #{id}"}

  def route(%Conv{method: "GET", path: "/pages/" <> static_page_slug} = conv) do
    # TODO Revisit semantic duplication relative to
    #      route(%Conv{method: "GET", path: "/bears/new"} = conv)
    @pages_path
    |> Path.join("#{static_page_slug}.html")
    |> File.read()
    |> case do
      {:ok, content} ->
        %{conv | status: 200, resp_body: content}

      {:error, :enoent} ->
        %{conv | status: 404, resp_body: "File not found!"}

      {:error, reason} ->
        Logger.warn("File error requesting #{static_page_slug}.html: #{reason}")
        %{conv | status: 500, resp_body: "File error: #{reason}"}
    end
  end

  def route(%Conv{method: "DELETE", path: "/bears/" <> _id} = conv),
    do: %{conv | status: 403, resp_body: "Bears can never be deleted!"}

  def route(%Conv{path: path} = conv), do: %{conv | status: 404, resp_body: "No #{path} here!"}

  @doc """
  Transform the `conv` map into a valid HTTP response string.
  """
  def format_response(%Conv{resp_body: resp_body} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Type: text/html
    Content-Length: #{byte_size(resp_body)}

    #{resp_body}
    """
  end
end
