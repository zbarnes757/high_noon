defmodule HighNoonWeb.AccountView do
  use JSONAPI.View, type: "accounts"

  def fields do
    [:email, :token]
  end
end
