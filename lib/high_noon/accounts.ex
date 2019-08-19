defmodule HighNoon.Accounts do
  alias HighNoon.Data.Account

  def create(attrs) do
    %Account{}
    |> Account.changeset(attrs)
    |> HighNoon.Repo.insert()
  end

  def get(id) do
    case HighNoon.Repo.get(Account, id) do
      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end
end
