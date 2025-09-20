defmodule ZornWeb.CustomComponents do
  use ZornWeb, :html

  attr :name, :string, required: true
  attr :stat_info, :map, required: true
  def stat_card(assigns) do
    ~H"""
    <div class={[
      "card w-96 shadow-md m-4",
      cond do
        @stat_info.value > 120 -> "bg-primary"
        @stat_info.value > 50 -> "bg-secondary"
      end
    ]}>
      <div class="card-body">
        <h2 class="card-title">{@name}: {@stat_info.value}</h2>
        <p>{@stat_info.desc}</p>
        <div class="card-actions justify-end">
          <%!-- <button class="btn btn-primary" phx-value-stat={@name} phx-click={"train"}>
          Train (-5)
          </button> --%>
          <.button phx-value-stat={@name} phx-click={"train"} variant="primary"> Train </.button>
        </div>
      </div>
    </div>
    """
  end
end
