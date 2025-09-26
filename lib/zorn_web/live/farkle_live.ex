defmodule ZornWeb.FarkleLive do
  use ZornWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <div class="card bg-base-200 shadow-xl p-6 max-w-2xl mx-auto my-8">
        <h2 class="card-title text-2xl mb-4">Farkle Rules</h2>
        <p class="mb-4">
          Farkle is a dice game where players roll six dice and try to score points by making certain combinations.
          Players take turns rolling and must decide whether to bank their points or risk rolling again.
        </p>

        <h3 class="text-xl font-semibold mb-2">Scoring</h3>
        <ul class="list-disc list-inside mb-4 space-y-1">
          <li>Each <span class="font-bold">1</span> = 100 points</li>
          <li>Each <span class="font-bold">5</span> = 50 points</li>
          <li>Three of a kind = Face value × 100 (e.g., three 4s = 400)</li>
          <li>Three 1s = 1,000 points</li>
          <li>Straight (1-6) = 1,500 points</li>
          <li>Three pairs = 1,500 points</li>
          <li>Four of a kind = 1,000 points</li>
          <li>Five of a kind = 2,000 points</li>
          <li>Six of a kind = 3,000 points</li>
        </ul>

        <h3 class="text-xl font-semibold mb-2">Gameplay</h3>
        <ol class="list-decimal list-inside space-y-1">
          <li>Roll all six dice.</li>
          <li>Set aside any scoring dice or combos.</li>
          <li>Decide whether to bank points or roll the remaining dice.</li>
          <li>If all dice score, you may roll all six again.</li>
          <li>If no dice score, you “Farkle” and lose points from that turn.</li>
        </ol>

        <p class="mt-4">
          First player to reach the winning score (usually <span class="font-bold">10,000 points</span>) wins.
        </p>
      </div>

    """
  end


end
