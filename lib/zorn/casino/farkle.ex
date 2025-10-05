defmodule Zorn.Casino.Farkle do
  defstruct dice_left: 6,
            kept_dice: [],
            score: 0,
            curr_roll: []

  def init do
    %__MODULE__{
      curr_roll: roll()
    }
  end

  def roll do
    Enum.map(1..%__MODULE__{}.dice_left, fn _ -> :rand.uniform(6) end)
  end

  def calculate_score(roll) do
    freq = Enum.frequencies(roll)

    if Enum.all?(freq, fn {_, count} -> count == 1 end) do
      3000
    else
      Enum.reduce(freq, 0, fn {num, count}, acc -> acc + score(num, count) end)
    end
  end

  defp score(1, 3), do: 1000
  defp score(1, count), do: 100 * count
  defp score(5, count) when count < 3, do: count * 50
  defp score(num, 3), do: num * 100
  defp score(_, 4), do: 1000
  defp score(_, 5), do: 2000
  defp score(_, 6), do: 3000
  defp score(_, _), do: 0
end

# Scoring
# ============
# ONES : 100
# FIVES : 50
# 3 ONES : 1000
# 3 TWOS : 200
# 3 THREES : 300
# 3 FOURS : 400
# 3 FIVES : 500
# 3 SIXES : 600
# 3 PAIRS : 1500
# 2 TRIPLETS : 2500 (todo... later)
# 4 OF A KIND : 1000
# 5 OF A KIND : 2000
# 6 OF A KIND : 3000
# STRAIGHT (1-2-3-4-5-6) : 1500
# ============
