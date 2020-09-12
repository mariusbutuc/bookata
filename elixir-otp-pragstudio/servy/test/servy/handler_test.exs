defmodule Servy.HandlerTest do
  use ExUnit.Case

  @request """
  GET /wildthings HTTP/1.1
  Host: example.com
  User-Agent: ExampleBrowser/1.0
  Accept: */*

  """

  test "handles a request" do
    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    Bears, Lions, Tigers
    """

    actual_response =
      @request
      |> Servy.Handler.handle()

    assert actual_response == expected_response
  end

  test "parses a request" do
    expected_response = %{method: "GET", path: "/wildthings", resp_body: ""}

    actual_response =
      @request
      |> Servy.Handler.parse()

    assert actual_response == expected_response
  end

  test "routes a conversation" do
    conversation = %{method: "GET", path: "/wildthings", resp_body: ""}
    expected_response = %{conversation | resp_body: "Bears, Lions, Tigers"}

    actual_response =
      conversation
      |> Servy.Handler.route()

    assert actual_response == expected_response
  end

  test "formats a conversation as a valid HTTP response string" do
    conversation = %{method: "GET", path: "/wildthings", resp_body: "Bears, Lions, Tigers"}

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    Bears, Lions, Tigers
    """

    actual_response =
      conversation
      |> Servy.Handler.format_response()

    assert actual_response == expected_response
  end
end
