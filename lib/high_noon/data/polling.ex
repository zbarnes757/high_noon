defmodule HighNoon.Data.Polling do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pollings" do
    field :last_ran, :utc_datetime
    field :next_run, :utc_datetime
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(polling, attrs) do
    polling
    |> cast(attrs, [:last_ran, :next_run, :title])
    |> validate_required([:title])
  end
end
