defmodule HighNoon.OWL.API do
  require Logger

  @uri "https://api.overwatchleague.com"

  def get_players() do
    Logger.debug(fn -> "[#{__MODULE__}] Fetching all player data..." end)

    case HTTPoison.get(@uri <> "/players") do
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, Jason.decode!(body)}

      {:error, %HTTPoison.Error{}} ->
        {:error, :failed_request}
    end
  end
end
