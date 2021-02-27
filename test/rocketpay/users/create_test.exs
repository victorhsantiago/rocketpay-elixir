defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.Repo
  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Benjamin Santiago",
        nickname: "Benjamin",
        email: "bemjamin@santiago.com",
        age: 18,
        password: "123456"
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Benjamin Santiago", age: 18, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Benjamin Santiago",
        nickname: "Benjamin",
        email: "bemjamin@santiago.com",
        age: 12,
      }

      {:error, changeset} = Create.call(params)

      expected_reponse = %{age: ["must be greater than or equal to 18"], password: ["can't be blank"]}

      assert expected_reponse == errors_on(changeset)
    end
  end
end
