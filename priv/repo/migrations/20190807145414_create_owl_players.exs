defmodule HighNoon.Repo.Migrations.CreateOwlPlayers do
  use Ecto.Migration

  def change do
    create table(:owl_players, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :esports_id, :integer, null: false
      add :data, :map, null: false

      timestamps(type: :utc_datetime, default: fragment("NOW()"))
    end

    create index("owl_players", [:esports_id], unique: true)
  end
end
