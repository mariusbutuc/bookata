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

    test "handles a request to create a new bear (GET /bears/new)" do
      expected_response =
        """
        HTTP/1.1 200 OK
        Content-Type: text/html
        Content-Length: 240

        <form action="/bears" method="POST">
          <p>
            Name:<br />
            <input type="text" name="name" />
          </p>
          <p>
            Type:<br />
            <input type="text" name="type" />
          </p>
          <p>
            <input type="submit" value="Create Bear" />
          </p>
        </form>
        """ <> "\n"

      # TODO Consider looking into this "hack". Is it "new line at end of file"?

      actual_response =
        "/bears/new"
        |> request()
        |> Servy.Handler.handle()

      assert actual_response == expected_response
    end

    test "handles a request to GET a specific /bears/1" do
      expected_response = """
      HTTP/1.1 200 OK
      Content-Type: text/html
      Content-Length: 6

      Bear 1
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

    test "serves a static file" do
      conversation = %{
        method: "GET",
        path: "/pages/about",
        resp_body: "",
        status: 200
      }

      expected_response = %{
        conversation
        | resp_body: """
          <h1>Clark's Wildthings Refuge</h1>

          <blockquote>
            When we contemplate the whole globe as one great dewdrop, striped and dotted
            with continents and islands, flying through space with other stars all singing
            and shining together as one, the whole universe appears as an infinite storm
            of beauty. -- John Muir
          </blockquote>
          """
      }

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

  def request(path, method \\ "GET") do
    """
    #{method} #{path} HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """
  end
end
