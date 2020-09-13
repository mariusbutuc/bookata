defmodule Servy.HandlerTest do
  use ExUnit.Case

  describe "handle/1" do
    test "handles a request to GET /wildthings" do
      expected_response = """
      HTTP/1.1 200 OK
      Content-Type: text/html
      Content-Length: 20

      Bears, Lions, Tigers
      """

      actual_response =
        "/wildthings"
        |> request()
        |> Servy.Handler.handle()

      assert actual_response == expected_response
    end

    test "handles a request to GET /bears" do
      expected_response = """
      HTTP/1.1 200 OK
      Content-Type: text/html
      Content-Length: 25

      Teddy, Smokey, Paddington
      """

      actual_response =
        "/bears"
        |> request()
        |> Servy.Handler.handle()

      assert actual_response == expected_response
    end

    test "does not handle a request to GET /bigfoot" do
      assert_raise FunctionClauseError, fn ->
        actual_response =
          "/bigfoot"
          |> request()
          |> Servy.Handler.handle()
      end
    end
  end

  describe "parse/1" do
    test "parses a request" do
      expected_response = %{method: "GET", path: "/wildthings", resp_body: ""}

      actual_response =
        "/wildthings"
        |> request()
        |> Servy.Handler.parse()

      assert actual_response == expected_response
    end
  end

  describe "route/1" do
    test "routes a conversation" do
      conversation = %{method: "GET", path: "/wildthings", resp_body: ""}
      expected_response = %{conversation | resp_body: "Bears, Lions, Tigers"}

      actual_response =
        conversation
        |> Servy.Handler.route()

      assert actual_response == expected_response
    end
  end

  describe "format_response/1" do
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

  def request(path) do
    """
    GET #{path} HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """
  end
end
