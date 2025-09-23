defmodule Zorn.Repo.Migrations.FixItemConstraints do
  # I ran this migration without hitting save lmao

  use Ecto.Migration

  def change do
    drop unique_index(:items, [:rarity])
  end
end
