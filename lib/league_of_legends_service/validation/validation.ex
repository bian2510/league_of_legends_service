defmodule LeagueOfLegendsService.Validation.Validation do
  alias LeagueOfLegendsService.Request.Requester

  #TODO: Validate number of players in a team

  def validation_for_create_tournament(params) do
    validate_if_players_exists(params)
  end

  def validate_if_players_exists(params) do
    players =
      get_in(params, ["data", "teams"])
      |> Enum.map(fn team ->
        get_in(team, ["players"])
        |> Enum.map(fn player ->
          name = String.downcase(player)

          case Requester.request_for_get_player_status_code(name) do
            500 -> %{error: "Internal error"}
            code -> %{name: name, code: code}
          end
        end)
      end)

    case Enum.all?(players, fn players_of_team ->
           Enum.all?(players_of_team, fn player -> player.code == 200 end) |> IO.inspect()
         end) do
      true -> validate_if_start_date_is_valid(params)
      false -> {:error, players}
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
