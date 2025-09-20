defmodule Zorn.Stats do
  def list_stats() do
    %{
      "Strength" => %{
        desc: "Strength incerases carry weight and melee damage",
        value: 90
      },
      "Agility" => %{
        desc: "Agility increases dodge chance and bow damage",
        value: 100
      },
      "Intelligence" => %{
        desc: "Intelligence increases mana and spell damage",
        value: 110
      },
      "Endurance" => %{
        desc: "Endurance increases travel speed and recovery rates",
        value: 100
      }
    }
  end
end
