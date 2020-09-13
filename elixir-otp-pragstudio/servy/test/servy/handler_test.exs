defmodule Servy.HandlerTest do
  use ExUnit.Case

  describe "handle/1" do
    test "handles a request to GET /wildthings" do
      expected_response = """
      HTTP/1.1 200 OK
      Content-Type: text/html
      Content-Length: 38

      🍌 Bears, Lions, Tigers 🙈🙉🙊
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
      Content-Length: 43

      🍌 Teddy, Smokey, Paddington 🙈🙉🙊
      """

      actual_response =
        "/bears"
        |> request()
        |> Servy.Handler.handle()

      assert actual_response == expected_response
    end

    test "handles a request to GET a specific /bears/1" do
      expected_response = """
      HTTP/1.1 200 OK
      Content-Type: text/html
      Content-Length: 24

      🍌 Bear 1 🙈🙉🙊
      """

      actual_response =
        "/bears/1"
        |> request()
        |> Servy.Handler.handle()

      assert actual_response == expected_response
    end

    test "handles a request to DELETE a specific /bears/1" do
      expected_response = """
      HTTP/1.1 403 Forbidden
      Content-Type: text/html
      Content-Length: 27

      Bears can never be deleted!
      """

      actual_response =
        "/bears/1"
        |> request("DELETE")
        |> Servy.Handler.handle()

      assert actual_response == expected_response
    end

    test "returns a 404 for non-matching paths" do
      expected_response = """
      HTTP/1.1 404 Not Found
      Content-Type: text/html
      Content-Length: 17

      No /bigfoot here!
      """

      actual_response =
        "/bigfoot"
        |> request()
        |> Servy.Handler.handle()

      assert actual_response == expected_response
    end
  end

  describe "parse/1" do
    test "parses a request" do
      expected_response = %{
        method: "GET",
        path: "/wildthings",
        resp_body: "",
        status: nil
      }

      actual_response =
        "/wildthings"
        |> request()
        |> Servy.Handler.parse()

      assert actual_response == expected_response
    end
  end

  describe "rewrite_path/1" do
    test "rewrites requests for /wildlife to /wildthings" do
      conversation = %{
        method: "GET",
        path: "/wildlife",
        resp_body: "",
        status: nil
      }

      expected_response = %{
        method: "GET",
        path: "/wildthings",
        resp_body: "",
        status: nil
      }

      actual_response =
        conversation
        |> Servy.Handler.rewrite_path()

      assert actual_response == expected_response
    end

    test "rewrites requests for /bears?id=1 to /bears/1" do
      conversation = %{
        method: "GET",
        path: "/bears?id=1",
        resp_body: "",
        status: nil
      }

      expected_response = %{
        method: "GET",
        path: "/bears/1",
        resp_body: "",
        status: nil
      }

      actual_response =
        conversation
        |> Servy.Handler.rewrite_path()

      assert actual_response == expected_response
    end
  end

  describe "route/1" do
    test "routes a conversation" do
      conversation = %{
        method: "GET",
        path: "/wildthings",
        resp_body: "",
        status: 200
      }
      expected_response = %{conversation | resp_body: "Bears, Lions, Tigers"}

      actual_response =
        conversation
        |> Servy.Handler.route()

      assert actual_response == expected_response
    end
  end

  describe "format_response/1" do
    test "formats a conversation as a valid HTTP response string" do
      conversation = %{
        method: "GET",
        path: "/wildthings",
        resp_body: "Bears, Lions, Tigers",
        status: 200
      }

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

  defp request(path, method \\ "GET") do
    """
    #{method} #{path} HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """
  end
end
