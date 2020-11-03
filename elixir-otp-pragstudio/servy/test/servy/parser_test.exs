defmodule Servy.ParserTest do
  use ExUnit.Case

  describe "parse/1" do
    test "parses a request" do
      expected_response = %{
        method: "GET",
        path: "/wildthings",
        resp_body: "",
        status: nil
      }

      actual_response =
        """
        GET /wildthings HTTP/1.1
        Host: example.com
        User-Agent: ExampleBrowser/1.0
        Accept: */*

        """
        |> Servy.Parser.parse()

      assert actual_response == expected_response
    end
  end
end
