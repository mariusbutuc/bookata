defmodule Servy.ParserTest do
  use ExUnit.Case

  import Servy.HandlerTest, only: [request: 1]

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
end
