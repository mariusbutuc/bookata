defmodule Servy.PluginsTest do
  use ExUnit.Case

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
        |> Servy.Plugins.rewrite_path()

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
        |> Servy.Plugins.rewrite_path()

      assert actual_response == expected_response
    end
  end
end
