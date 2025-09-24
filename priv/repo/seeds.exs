# Seeds for generating weapons and armor
alias Zorn.Repo
alias Zorn.Game.Item

# Clear existing items (optional)
Repo.delete_all(Item)

defmodule ItemGenerator do
  # Material configurations
  @weapon_materials [:stone, :bronze, :iron, :steel, :meteorite, :adamantine]
  @armor_materials [:leather, :bronze, :iron, :steel, :meteorite, :adamantine]
  @rarities [:common, :uncommon, :rare, :legendary]
  @armor_types [:helmet, :chest, :boots, :gloves, :cape, :leg]
  @weapon_types [
    %{name: "Sword", base_damage: 20.0, base_speed: 1.2, weight_modifier: 1.0},
    %{name: "Axe", base_damage: 25.0, base_speed: 0.9, weight_modifier: 1.2},
    %{name: "Dagger", base_damage: 12.0, base_speed: 2.0, weight_modifier: 0.5},
    %{name: "Mace", base_damage: 22.0, base_speed: 1.0, weight_modifier: 1.3},
    %{name: "Spear", base_damage: 18.0, base_speed: 1.4, weight_modifier: 0.8},
    %{name: "Bow", base_damage: 15.0, base_speed: 1.8, weight_modifier: 0.6}
  ]

  # Material stat multipliers
  def material_multiplier(material) do
    case material do
      :stone -> %{damage: 0.7, speed: 0.8, defense: 0.6, value: 1.0, weight: 1.5}
      :leather -> %{damage: 0.0, speed: 1.0, defense: 0.5, value: 1.2, weight: 0.8}
      :bronze -> %{damage: 1.0, speed: 1.0, defense: 1.0, value: 2.0, weight: 1.2}
      :iron -> %{damage: 1.3, speed: 1.1, defense: 1.3, value: 3.5, weight: 1.4}
      :steel -> %{damage: 1.6, speed: 1.2, defense: 1.6, value: 6.0, weight: 1.3}
      :meteorite -> %{damage: 2.0, speed: 1.4, defense: 2.0, value: 12.0, weight: 1.1}
      :adamantine -> %{damage: 2.5, speed: 1.6, defense: 2.5, value: 25.0, weight: 1.0}
    end
  end

  # Rarity stat multipliers
  def rarity_multiplier(rarity) do
    case rarity do
      :common -> %{stats: 1.0, value: 1.0}
      :uncommon -> %{stats: 1.15, value: 1.5}
      :rare -> %{stats: 1.35, value: 2.5}
      :legendary -> %{stats: 1.6, value: 5.0}
    end
  end

  # Generate special effects based on material and rarity
  def generate_effects(material, rarity) do
    material_effects = case material do
      :meteorite -> ["Cosmic energy radiates from this item"]
      :adamantine -> ["Indestructible material that never dulls"]
      _ -> []
    end

    rarity_effects = case rarity do
      :rare -> ["Glows with magical energy"]
      :legendary -> ["Glows with magical energy", "Whispers ancient secrets"]
      _ -> []
    end

    effects = material_effects ++ rarity_effects
    if effects == [], do: "None", else: Enum.join(effects, ", ")
  end

  # Generate armor description
  def armor_description(material, armor_type, rarity) do
    material_desc = case material do
      :leather -> "supple leather"
      :bronze -> "gleaming bronze"
      :iron -> "sturdy iron"
      :steel -> "polished steel"
      :meteorite -> "otherworldly meteorite"
      :adamantine -> "legendary adamantine"
    end

    type_desc = case armor_type do
      :helmet -> "head protection"
      :chest -> "torso armor"
      :boots -> "footwear"
      :gloves -> "hand protection"
      :cape -> "flowing cape"
      :leg -> "leg armor"
    end

    quality_desc = case rarity do
      :common -> "Basic"
      :uncommon -> "Well-crafted"
      :rare -> "Masterfully forged"
      :legendary -> "Divinely crafted"
    end

    "#{quality_desc} #{type_desc} made from #{material_desc}."
  end

  # Generate weapon description
  def weapon_description(material, weapon_name, rarity) do
    material_desc = case material do
      :stone -> "primitive stone"
      :bronze -> "gleaming bronze"
      :iron -> "sturdy iron"
      :steel -> "polished steel"
      :meteorite -> "otherworldly meteorite"
      :adamantine -> "legendary adamantine"
    end

    quality_desc = case rarity do
      :common -> "A basic"
      :uncommon -> "A well-crafted"
      :rare -> "A masterfully forged"
      :legendary -> "A divinely crafted"
    end

    "#{quality_desc} #{String.downcase(weapon_name)} made from #{material_desc}."
  end

  # Generate weapons
  def generate_weapons do
    for material <- @weapon_materials,
        weapon <- @weapon_types,
        rarity <- @rarities do

      material_mult = material_multiplier(material)
      rarity_mult = rarity_multiplier(rarity)

      damage = (weapon.base_damage * material_mult.damage * rarity_mult.stats) |> Float.round(1)
      attack_speed = (weapon.base_speed * material_mult.speed * rarity_mult.stats) |> Float.round(1)
      base_value = trunc(100 * material_mult.value * rarity_mult.value)
      weight = trunc(3 * weapon.weight_modifier * material_mult.weight)

      %{
        name: "#{String.capitalize(to_string(material))} #{weapon.name}",
        description: weapon_description(material, weapon.name, rarity),
        category: :weapon,
        rarity: rarity,
        value: base_value,
        icon_url: "/images/weapons/#{material}_#{String.downcase(weapon.name)}.jpg",
        weight: max(weight, 1),
        damage: damage,
        attack_speed: attack_speed,
        defense: 0.0,
        armor_type: :helmet, # Dummy value to satisfy validation
        effect: generate_effects(material, rarity)
      }
    end
  end

  # Generate armor
  def generate_armor do
    for material <- @armor_materials,
        armor_type <- @armor_types,
        rarity <- @rarities do

      material_mult = material_multiplier(material)
      rarity_mult = rarity_multiplier(rarity)

      base_defense = case armor_type do
        :helmet -> 8.0
        :chest -> 25.0
        :boots -> 6.0
        :gloves -> 4.0
        :cape -> 5.0
        :leg -> 15.0
      end

      defense = (base_defense * material_mult.defense * rarity_mult.stats) |> Float.round(1)
      base_value = trunc(50 * material_mult.value * rarity_mult.value)

      base_weight = case armor_type do
        :helmet -> 2
        :chest -> 8
        :boots -> 3
        :gloves -> 1
        :cape -> 2
        :leg -> 5
      end

      weight = trunc(base_weight * material_mult.weight)

      %{
        name: "#{String.capitalize(to_string(material))} #{String.capitalize(to_string(armor_type))}",
        description: armor_description(material, armor_type, rarity),
        category: :armor,
        rarity: rarity,
        value: base_value,
        icon_url: "/images/armor/#{material}_#{armor_type}.jpg",
        weight: max(weight, 1),
        damage: 0.0,
        attack_speed: 0.0,
        defense: defense,
        armor_type: armor_type,
        effect: generate_effects(material, rarity)
      }
    end
  end

  def generate_all_items do
    generate_weapons() ++ generate_armor()
  end
end

# Generate and insert all items
all_items = ItemGenerator.generate_all_items()

IO.puts("Generating #{length(all_items)} items...")

Enum.each(all_items, fn item_attrs ->
  %Item{}
  |> Item.changeset(item_attrs)
  |> Repo.insert!()
end)

weapons_count = Enum.count(all_items, fn item -> item.category == :weapon end)
armor_count = Enum.count(all_items, fn item -> item.category == :armor end)

IO.puts("Successfully seeded #{weapons_count} weapons and #{armor_count} armor pieces!")
IO.puts("Total items: #{length(all_items)}")
