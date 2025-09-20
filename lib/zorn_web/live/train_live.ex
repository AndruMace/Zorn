defmodule ZornWeb.TrainLive do
  use ZornWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket), do: Process.send_after(self(), :tick, 2000)

    {
      :ok,
      assign(
        socket,
        energy_to_train: 10,
        energy: 100,
        stats: Zorn.Stats.list_stats()
      )
    }
  end

  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 2000)

    cond do
      socket.assigns.energy < 100  ->
        {:noreply, assign(socket, energy: socket.assigns.energy + 5)}
      true ->
        {:noreply, socket}
    end
  end

  def handle_event("train", %{"stat" => stat}, socket) do
    # stat_to_update = socket.assigns.stats[stat]

    socket = assign(
      socket,
      # stats: %{socket.assigns.stats | stat => Map.update!(stat_to_update, :value, &(&1 + 10))},
      stats: update_in(socket.assigns.stats, [stat, :value], &(&1 + 10)),
      energy: socket.assigns.energy - 10
    )

    {:noreply, socket}
  end

  @spec render(any()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div>
      <h1 class="p-4">
        Energy {@energy}
      </h1>
      <div class="p-4">
        <%= for {name, stat_info} <- @stats do %>
          <div class="card bg-secondary w-96 shadow-md m-4">
            <div class="card-body">
              <h2 class="card-title">{name}: {stat_info.value}</h2>
              <p>{stat_info.desc}</p>
              <div class="card-actions justify-end">
                <button class="btn btn-primary" phx-value-stat={name} phx-click={"train"}>
                Train (-5 energy)
                </button>
              </div>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
