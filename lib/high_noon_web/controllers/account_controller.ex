defmodule HighNoonWeb.AccountController do
  use HighNoonWeb, :controller

  def create(conn, %{"data" => %{"type" => "accounts", "attributes" => attrs}}) do
    with {:ok, account} <- HighNoon.Accounts.create(attrs),
         {:ok, token, _claims} <- HighNoonWeb.Guardian.encode_and_sign(account)
     do
      render(conn, "show.json", %{data: %{account | token: token}})
    end
  end
end
