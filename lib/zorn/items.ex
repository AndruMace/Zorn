defmodule Zorn.Items do
  alias Zorn.Repo
  alias Zorn.Game.Item
  import Ecto.Query

  def list_items, do: Repo.all(Item)

  def get_item!(id), do: Repo.get!(Item, id)

  def filter_items(filter) do
    Item
    |> with_category(filter["category"])
    |> where([r], ilike(r.name, ^"%#{filter["q"]}%"))
    |> sort_by(filter["sort_by"])
    |> Repo.all()
  end

  def category_form_validation do
    Ecto.Enum.values(Zorn.Game.Item, :category)
  end

  defp sort_by(query, "rarity") do
    order_by(query, [i],
      fragment("CASE ?
                WHEN 'legendary' THEN 1
                WHEN 'rare' THEN 2
                WHEN 'uncommon' THEN 3
                WHEN 'common' THEN 4
                ELSE 5 END", i.rarity)
    )
  end

  defp sort_by(query, sort_field) when sort_field in ["value", "weight"] do
    order_by(query, desc: ^String.to_existing_atom(sort_field))
  end

  defp sort_by(query, _), do: query

  defp with_category(query, category) when category in ~w(armor weapon consumable) do
    where(query, category: ^category)
  end

  defp with_category(query, _), do: query
end
