defmodule Zorn.Repo.Migrations.AddStatsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :strength, :float
      add :agility, :float
      add :endurance, :float
      add :intelligence, :float
      add :dexterity, :float
    end
  end
end
