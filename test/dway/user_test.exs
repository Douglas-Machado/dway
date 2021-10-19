defmodule Dway.UserTest do
  use Dway.DataCase, async: true

  alias Dway.Accounts.User
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when the param is valid, returns a valid changeset" do
      params = %{email: "manara@d.com"}

      response = User.changeset(params)

      assert %Changeset{changes: %{email: "manara@d.com"}, valid?: true} = response
    end

    test "when there is an error, returns an invalid changeset" do
      params = %{email: "mana as 3"}

      response = User.changeset(params)

      expected_response = %{email: ["E-mail deve possuir @ e não conter espaços"]}

      assert errors_on(response) == expected_response
    end
  end
end
