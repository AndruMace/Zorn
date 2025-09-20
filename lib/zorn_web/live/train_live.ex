defmodule ZornWeb.TrainLive do
  use ZornWeb, :live_view

  @stats [
    %{
      name: "Strength",
      desc: "Strength incerases carry weight and melee damage"
    },
    %{
      name: "Agility",
      desc: "Agility increases dodge chance and bow damage"
    },
    %{
      name: "Intelligence",
      desc: "Intelligence increases mana and spell damage"
    },
    %{
      name: "Endurance",
      desc: "Endurance increases travel speed and recovery rates"
    }
  ]

  def mount(_params, _session, socket) do
    if connected?(socket), do: Process.send_after(self(), :tick, 2000)

    {
      :ok,
      assign(
        socket,
        curr_stats: %{"Strength" => 100, "Agility" =>  90, "Intelligence" => 100, "Endurance" => 100},
        energy_to_train: 10,
        energy: 100,
        stats: @stats
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
    socket = assign(
      socket,
      curr_stats: Map.update!(
        socket.assigns.curr_stats,
        stat,
        fn curr -> curr + 10 end
      ),
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
        <%= for stat <- @stats do %>
          <div class="card bg-secondary w-96 shadow-md m-4">
            <div class="card-body">
              <h2 class="card-title">{stat.name}: {@curr_stats[stat.name]}</h2>
              <p>{stat.desc}</p>
              <div class="card-actions justify-end">
                <button class="btn btn-primary" phx-value-stat={stat.name} phx-click={"train"}>
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
