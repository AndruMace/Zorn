defmodule Zorn.Repo.Migrations.FixItemConstraints do
  use Ecto.Migration

  # I saved before migrating this time.... oops

  def change do
    drop unique_index(:items, [:rarity])
  end
end
