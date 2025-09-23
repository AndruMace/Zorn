defmodule ZornWeb.ItemsLive do
  use ZornWeb, :live_view
  alias Zorn.Items

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(unsigned_params, _uri, socket) do
    socket =
      socket
      |> assign(layout: {ZornWeb.Layouts, :simple}, form: to_form(unsigned_params))
      |> stream(:items, Items.filter_items(unsigned_params), reset: true)

    {:noreply, socket}
  end

  def handle_event("filter", unsigned_params, socket) do
    unsigned_params =
      unsigned_params
      |> Map.take(~w(q category sort_by))
      |> Map.reject(fn {_, v} -> v == "" end)

    socket = push_patch(socket, to: ~p"/items?#{unsigned_params}")

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
      <h1>All Game Items</h1>
      <.form for={@form} id="filter-form" phx-change="filter">
        <.input
          field={@form[:q]}
          placeholder="Search..."
          autocomplete="off"
          phx-debounce="200"/>
        <.input
          type="select"
          field={@form[:category]}
          prompt="Category"
          options={Items.category_form_validation()}
        />
        <.input
          type="select"
          field={@form[:sort_by]}
          prompt="Sort By"
          options={[:rarity, :value, :weight]}
        />
        <.link patch={~p(/items)}>
          Reset
        </.link>
      </.form>
      <div>
        <ul class="list bg-base-100 rounded-box shadow-md" phx-update="stream" id="items-list">
          <div id="empty" class="no-results only:block hidden">
            No items found. Try changing your filters.
          </div>
          <li :for={{dom_id, item} <- @streams.items} id={dom_id}>
            <div>
              <img class="size-10 rounded-box" src="/images/item_placeholder.jpg"/>
            </div>
            <div>
              <div>{item.name} - {item.rarity}</div>
              <div class="text-xs uppercase font-semibold opacity-60">{item.description}</div>
              <p class="list-col-wrap text-xs">
                {item.value}g, {item.weight}lb
              </p>
            </div>
          </li>
        </ul>
      </div>
    """
  end
end
