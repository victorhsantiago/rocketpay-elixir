defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.{Account, User}

  test "renders create.json" do
    params = %{
      name: "Benjamin Santiago",
      nickname: "Benjamin",
      email: "bemjamin@santiago.com",
      age: 18,
      password: "123456"
    }

    {:ok, %User{id: _user_id, account: %Account{id: account_id}} = user} =
      Rocketpay.create_user(params)

    response = render(RocketpayWeb.UsersView, "create.json", user: user)

    _expected_response = %{
             message: "User created",
             user: %{
               account: %{
                 balance: Decimal.new("0.00"),
                 id: account_id
               },
               id: "7ed8dcbe-95c1-4d16-a6b4-d71e9ae0c200",
               name: "Benjamin Santiago",
               nickname: "Benjamin"
             }
           }

    assert _expected_response = response
  end
end
