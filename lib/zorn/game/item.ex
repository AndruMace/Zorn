defmodule Zorn.Game.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :description, :string
    field :category, Ecto.Enum, values: [:weapon, :consumable, :armor]
    field :rarity, Ecto.Enum, values: [:common, :uncommon, :rare, :legendary]
    field :value, :integer
    field :icon_url, :string, default: "/images/item_placeholder.jpg"
    field :weight, :integer, default: 1
    field :damage, :float
    field :attack_speed, :float
    field :defense, :float
    field :armor_type, Ecto.Enum, values: [:helmet, :chest, :boots, :gloves, :cape, :leg]
    field :effect, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  # def changeset(item, attrs) do
  #   item
  #   |> cast(attrs, [:name, :description, :category, :rarity, :value, :icon_url, :weight, :damage, :attack_speed, :defense, :armor_type, :effect])
  #   |> validate_required([:name, :description, :category, :rarity, :value, :icon_url, :weight, :damage, :attack_speed, :defense, :armor_type, :effect])
  #   |> unique_constraint(:rarity)
  # end

def changeset(item, attrs) do
  item
  |> cast(attrs, [:name, :description, :category, :rarity, :value, :icon_url, :weight, :damage, :attack_speed, :defense, :armor_type, :effect])
  |> validate_required([:name, :description, :category, :rarity, :value, :icon_url, :weight, :effect])
  |> validate_armor_type_for_armor()
  |> unique_constraint(:name)  # Changed from :rarity to :name
end

defp validate_armor_type_for_armor(changeset) do
  case get_field(changeset, :category) do
    :armor -> validate_required(changeset, [:armor_type])
    _ -> changeset
  end
end
end
