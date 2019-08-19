defmodule HighNoon.OWLPlayers.Server do
  use GenServer
  require Ecto.Query
  require Logger

  alias HighNoon.Data.Polling
  alias HighNoon.Data.OWL.Players

  @seven_days 7 * 24 * 60 * 60

  ## API

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  ## Callbacks

  @impl true
  def init(_) do
    next_run = fetch_next_run()

    timer_ref = process_after(next_run)

    {:ok, timer_ref}
  end

  @impl true
  def handle_info(:run, _state) do
    Logger.debug(fn -> "[#{__MODULE__}] Starting update player process..." end)

    case HighNoon.OWL.API.get_players() do
      {:ok, %{"content" => all_players}} ->
        Logger.debug(fn -> "[#{__MODULE__}] Updating players..." end)

        save_players(all_players)

      {:error, :failed_request} ->
        nil
    end

    Logger.debug(fn -> "[#{__MODULE__}] Scheduling next run..." end)
    next_run = update_next_run()
    timer_ref = process_after(next_run)

    {:noreply, timer_ref}
  end

  ## Private

  defp process_after(%DateTime{} = next_run) do
    send_after_time =
      next_run
      |> DateTime.to_unix(:millisecond)
      |> Kernel.-(DateTime.to_unix(DateTime.utc_now(), :millisecond))
      |> abs()

    Process.send_after(__MODULE__, :run, send_after_time)
  end

  defp save_players(all_players) do
    all_players =
      Enum.map(all_players, fn %{"id" => id} = player -> %{esports_id: id, data: player} end)

    HighNoon.Repo.insert_all(Players, all_players,
      on_conflict: :replace_all_except_primary_key,
      conflict_target: :esports_id
    )
  end

  defp update_next_run() do
    now = DateTime.utc_now()
    next_run = DateTime.add(DateTime.utc_now(), @seven_days, :second)

    Polling
    |> Ecto.Query.where(title: "player_update")
    |> HighNoon.Repo.update_all(set: [last_ran: now, next_run: next_run, updated_at: now])

    next_run
  end

  defp fetch_next_run() do
    Polling
    |> Ecto.Query.where(title: "player_update")
    |> HighNoon.Repo.one()
    |> case do
      %Polling{next_run: nil} ->
        DateTime.add(DateTime.utc_now(), 10, :second)

      %Polling{next_run: next_run} ->
        next_run

      nil ->
        DateTime.add(DateTime.utc_now(), 10, :second)
    end
  end
end
