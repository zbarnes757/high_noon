defmodule HighNoon.Repo.Migrations.CreatePollings do
  use Ecto.Migration

  def change do
    create table(:pollings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :last_ran, :utc_datetime
      add :next_run, :utc_datetime
      add :title, :string, null: false

      timestamps(type: :utc_datetime, default: fragment("NOW()"))
    end
  end
end
