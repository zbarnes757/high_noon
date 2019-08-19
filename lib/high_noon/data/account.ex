defmodule HighNoon.Data.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :email, :string
    field :password, :string, virtual: true
    field :token, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = account, attrs) do
    account
    |> cast(attrs, [:email, :password])
    |> put_password_hash()
    |> validate_required([:email, :password_hash])
    |> unique_constraint(:email)
  end

  # Private

  defp put_password_hash(changeset) do
    case get_change(changeset, :password) do
      nil ->
        changeset

      password ->
        hash = Bcrypt.hash_pwd_salt(password)
        put_change(changeset, :password_hash, hash)
    end
  end
end
