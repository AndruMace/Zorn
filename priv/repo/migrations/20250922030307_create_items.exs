defmodule Zorn.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :description, :text
      add :category, :string
      add :rarity, :string
      add :value, :integer
      add :icon_url, :string
      add :weight, :integer
      add :damage, :float
      add :attack_speed, :float
      add :defense, :float
      add :armor_type, :string
      add :effect, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:items, [:rarity])
  end
end
