defmodule ZornWeb.ProfileLive.Inventory do
  use ZornWeb, :live_view

  def mount(%{"username" => username}, _session, socket) do
    # user = User.get_user(username)
    # socket = assign(socket, :user, user)
    {:ok, socket}
  end

  def render(assigns) do
  ~H"""
    <div class="p-6 border">
      <h1 class="text-2xl font-bold text-yellow-400 mb-4">Inventory</h1>

      <ul class="divide-y divide-gray-700">
        <!-- Mock Item 1 -->
        <li class="flex justify-between items-center py-3">
          <div>
            <span class="font-semibold text-yellow-300">Iron Sword</span>
            <span class="block text-sm text-gray-400">A sturdy blade, slightly worn but reliable.</span>
          </div>
          <button class="px-3 py-1 bg-yellow-700 text-gray-100 rounded hover:bg-yellow-600">
            Equip
          </button>
        </li>

        <!-- Mock Item 2 -->
        <li class="flex justify-between items-center py-3">
          <div>
            <span class="font-semibold text-yellow-300">Leather Armor</span>
            <span class="block text-sm text-gray-400">Lightweight armor offering modest protection.</span>
          </div>
          <button class="px-3 py-1 bg-yellow-700 text-gray-100 rounded hover:bg-yellow-600">
            Equip
          </button>
        </li>

        <!-- Mock Item 3 -->
        <li class="flex justify-between items-center py-3">
          <div>
            <span class="font-semibold text-yellow-300">Healing Potion</span>
            <span class="block text-sm text-gray-400">Restores 50 HP when consumed.</span>
          </div>
          <button class="px-3 py-1 bg-yellow-700 text-gray-100 rounded hover:bg-yellow-600">
            Use
          </button>
        </li>
      </ul>
    </div>
  """
  end

end
