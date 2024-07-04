# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rumbl.Repo.insert!(%Rumbl.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rumbl.Repo
alias Rumbl.Accounts
alias Rumbl.Accounts.User

if Accounts.list_users() == [] do
  [
    %User{name: "José", username: "josevalim"},
    %User{name: "Bruce", username: "redrapids"},
    %User{name: "Chris", username: "chrismccord"},
    %User{name: "Marius", username: "mariusbutuc"}
  ]
  # FIXME: Insert Users through the Accounts context, instead of bypassing straight to Repo
  |> Enum.map(&Repo.insert!/1)
end
