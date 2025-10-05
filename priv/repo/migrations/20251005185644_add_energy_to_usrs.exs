defmodule Zorn.Repo.Migrations.AddEnergyToUsrs do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :energy, :integer
    end
  end
end
