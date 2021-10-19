defmodule Dway.Users.AccountsTest do
  use Dway.DataCase, async: true

  alias Dway.Accounts.User
  alias Dway.Accounts

  describe "call/1" do
    test "when the param is valid, returns the user" do
      params = %{email: "stefano@madagascar.com"}

      response = Accounts.call(params)

      assert {:ok, %User{id: _id, email: "stefano@madagascar.com"}} = response
    end

    test "when there is an error, returns an error" do
      params = %{email: "doug as 3"}

      response = Accounts.call(params)

      expected_response = %{email: ["E-mail deve possuir @ e não conter espaços"]}

      assert {:error, %{status: :bad_request, result: changeset}} = response

      assert errors_on(changeset) == expected_response
    end
  end
end
