defmodule ZornWeb.ProfileLive.Inventory do
  use ZornWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <div>
        <h1>Inventory</h1>
      </div>
    """
  end
end
