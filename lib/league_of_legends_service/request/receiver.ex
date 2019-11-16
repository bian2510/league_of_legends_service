defmodule LeagueOfLegendsService.Request.Receiver do
  def send_request(params) do
    players = params["data"]["players"]

    case LeagueOfLegendsService.Request.Validation.validate_if_players_exists?(players) do
      true -> params
      error -> error
    end
  end
end
