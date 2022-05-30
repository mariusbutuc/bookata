defmodule Rumbl.Accounts do
  @moduledoc """
  The Acounts context
  """

  alias Rumbl.Accounts.User

  def list_users do
    [
      %User{id: "1", name: "José Valim", username: "josevalim"},
      %User{id: "2", name: "Bruce Tate", username: "redrapids"},
      %User{id: "3", name: "Chris McCord", username: "chrismccord"},
      %User{id: "4", name: "Marius Butuc", username: "mariusbutuc"}
    ]
  end

  def get_user(id) do
    list_users()
    |> Enum.find(fn user -> user.id == id end)
  end

  def get_user_by(params) do
    list_users()
    |> Enum.find(fn user ->
      Enum.all?(params, fn {key, val} -> Map.get(user, key) == val end)
    end)
  end
end
