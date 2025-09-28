defmodule Zorn.Casino.Farkle do
  defstruct active_dice_count: 6, kept_dice: [], score: 0, curr_roll: []

  def init do
    %__MODULE__{
      curr_roll: roll()
    }
  end

  def roll(num_dice \\ 6) do
    for _idx <- 1..num_dice do
      Enum.random(1..6)
    end
  end

  def keep(roll) when is_list(roll), do: roll
  # def keep(roll, keeping) do
  #   {rolling, taking} =
  #     roll
  #     |> Enum.split_with(fn i -> )
  # end

  def score(roll) do
    roll
  end
end
