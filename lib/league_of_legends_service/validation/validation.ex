defmodule LeagueOfLegendsService.Validation.Validation do
  alias LeagueOfLegendsService.Request.Requester

  def validation_for_create_tournament(params) do
    validate_if_players_exists(params)
  end

  def validate_if_players_exists(params) do
    players = params["data"]["players"]

    players_with_status =
      Enum.map(players, fn player ->
        name = String.downcase(player)
        endpoint = "summoner/v4/summoners/by-name/"

        case Requester.requester_for_get_player_status_code(endpoint, name) do
          200 -> %{name: name, code: 200}
          code -> %{name: name, code: code}
        end
      end)

    case Enum.all?(players_with_status, fn player -> player.code == 200 end) do
      true -> validate_if_start_date_is_valid(params)
      false -> {:error, players_with_status}
    end
  end

  def validate_if_start_date_is_valid(params) do
    start_date = params["data"]["start_date"]
    date_now = DateTime.utc_now()
    date = DateTime.from_iso8601(start_date) |> elem(1)

    case date_now < date do
      true -> validate_if_end_date_is_valid(params)
      false -> {:error, %{error: "The start date is invalid"}}
    end
  end

  def validate_if_end_date_is_valid(params) do
    end_date = params["data"]["end_date"]
    start_date = params["data"]["start_date"]

    case start_date < end_date do
      true -> validate_duration(params)
      false -> {:error, %{error: "The end date is invalid"}}
    end
  end

  def validate_duration(params) do
    end_date = params["data"]["end_date"] |> DateTime.from_iso8601() |> elem(1)
    start_date = params["data"]["start_date"] |> DateTime.from_iso8601() |> elem(1)
    duration = DateTime.diff(end_date, start_date)

    case duration > 0 && duration <= 86400 do
      true -> true
      false -> {:error, %{error: "The duration is invalid"}}
    end
  end
end
