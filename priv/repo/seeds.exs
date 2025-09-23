alias Zorn.Repo
alias Zorn.Game.Item

@materials ~w(Stone Bronze Iron Steel Orichalcum Adamantine)
@melee_weapon_types ~w(Sword Axe Maul Spear)

# Clear existing items
Repo.delete_all(Item)

def generate_weapon do

end

weapons = [
  %{
    name: "Iron Sword",
    description: "A sturdy iron blade forged by skilled blacksmiths.",
    category: :weapon,
    rarity: :common,
    value: 150,
    icon_url: "/images/iron_sword.jpg",
    weight: 3,
    damage: 25.0,
    attack_speed: 1.2,
    defense: 0.0,
    armor_type: nil,
    effect: "None"
  },
  %{
    name: "Flamebrand",
    description: "A legendary sword that burns with eternal flame.",
    category: :weapon,
    rarity: :legendary,
    value: 5000,
    icon_url: "/images/flamebrand.jpg",
    weight: 4,
    damage: 85.0,
    attack_speed: 1.5,
    defense: 0.0,
    armor_type: nil,
    effect: "Fire damage over time"
  },
  %{
    name: "Steel Dagger",
    description: "A quick and nimble blade perfect for stealth attacks.",
    category: :weapon,
    rarity: :uncommon,
    value: 300,
    icon_url: "/images/steel_dagger.jpg",
    weight: 1,
    damage: 18.0,
    attack_speed: 2.0,
    defense: 0.0,
    armor_type: nil,
    effect: "Increased critical hit chance"
  },
  %{
    name: "Dragonbone Axe",
    description: "An axe carved from ancient dragon bones, incredibly powerful.",
    category: :weapon,
    rarity: :rare,
    value: 2500,
    icon_url: "/images/dragonbone_axe.jpg",
    weight: 6,
    damage: 65.0,
    attack_speed: 0.8,
    defense: 0.0,
    armor_type: nil,
    effect: "Armor penetration"
  }
]

armor_items = [
  %{
    name: "Leather Helmet",
    description: "Basic protection for your head.",
    category: :armor,
    rarity: :common,
    value: 50,
    icon_url: "/images/leather_helmet.jpg",
    weight: 1,
    damage: 0.0,
    attack_speed: 0.0,
    defense: 5.0,
    armor_type: :helmet,
    effect: "None"
  },
  %{
    name: "Steel Chestplate",
    description: "Heavy steel armor that provides excellent protection.",
    category: :armor,
    rarity: :uncommon,
    value: 800,
    icon_url: "/images/steel_chestplate.jpg",
    weight: 8,
    damage: 0.0,
    attack_speed: 0.0,
    defense: 35.0,
    armor_type: :chest,
    effect: "Reduces movement speed by 10%"
  },
  %{
    name: "Dragon Scale Boots",
    description: "Boots crafted from dragon scales, light yet durable.",
    category: :armor,
    rarity: :rare,
    value: 1500,
    icon_url: "/images/dragon_boots.jpg",
    weight: 2,
    damage: 0.0,
    attack_speed: 0.0,
    defense: 20.0,
    armor_type: :boots,
    effect: "Fire resistance"
  },
  %{
    name: "Celestial Gloves",
    description: "Gloves blessed by celestial beings, radiating divine power.",
    category: :armor,
    rarity: :legendary,
    value: 3500,
    icon_url: "/images/celestial_gloves.jpg",
    weight: 1,
    damage: 0.0,
    attack_speed: 0.0,
    defense: 15.0,
    armor_type: :gloves,
    effect: "Mana regeneration +50%"
  },
  %{
    name: "Shadow Cape",
    description: "A dark cape that seems to absorb light around it.",
    category: :armor,
    rarity: :rare,
    value: 1200,
    icon_url: "/images/shadow_cape.jpg",
    weight: 1,
    damage: 0.0,
    attack_speed: 0.0,
    defense: 10.0,
    armor_type: :cape,
    effect: "Stealth +25%"
  },
  %{
    name: "Iron Leggings",
    description: "Sturdy iron leg protection for warriors.",
    category: :armor,
    rarity: :common,
    value: 200,
    icon_url: "/images/iron_leggings.jpg",
    weight: 4,
    damage: 0.0,
    attack_speed: 0.0,
    defense: 18.0,
    armor_type: :leg,
    effect: "None"
  }
]

consumables = [
  %{
    name: "Health Potion",
    description: "A red potion that restores health when consumed.",
    category: :consumable,
    rarity: :common,
    value: 25,
    icon_url: "/images/health_potion.jpg",
    weight: 1,
    damage: 0.0,
    attack_speed: 0.0,
    defense: 0.0,
    armor_type: nil,
    effect: "Restores 50 HP"
  },
  %{
    name: "Mana Elixir",
    description: "A blue elixir that restores magical energy.",
    category: :consumable,
    rarity: :uncommon,
    value: 75,
    icon_url: "/images/mana_elixir.jpg",
    weight: 1,
    damage: 0.0,
    attack_speed: 0.0,
    defense: 0.0,
    armor_type: nil,
    effect: "Restores 100 MP"
  },
  %{
    name: "Phoenix Feather",
    description: "A rare feather that can bring someone back from the brink of death.",
    category: :consumable,
    rarity: :legendary,
    value: 10000,
    icon_url: "/images/phoenix_feather.jpg",
    weight: 1,
    damage: 0.0,
    attack_speed: 0.0,
    defense: 0.0,
    armor_type: nil,
    effect: "Full resurrection with 100% HP/MP"
  },
  %{
    name: "Strength Tonic",
    description: "A powerful tonic that temporarily increases physical prowess.",
    category: :consumable,
    rarity: :rare,
    value: 500,
    icon_url: "/images/strength_tonic.jpg",
    weight: 1,
    damage: 0.0,
    attack_speed: 0.0,
    defense: 0.0,
    armor_type: nil,
    effect: "Damage +50% for 300 seconds"
  }
]

all_items = weapons ++ armor_items ++ consumables

Enum.each(all_items, fn item_attrs ->
  %Item{}
  |> Item.changeset(item_attrs)
  |> Repo.insert!()
end)

IO.puts("Seeded #{length(all_items)} items successfully!")
