defmodule LeagueOfLegendsService.Request.Validation do
  def validate_if_players_exists?(players) do
    players_with_status =
      Enum.map(players, fn player ->
        name = String.downcase(player["name"])
        url = "https://la2.api.riotgames.com/lol/summoner/v4/summoners/by-name/#{name}"

        case requester(url) do
          200 -> %{name: name, code: 200}
          code -> %{name: name, code: code}
        end
      end)

    case Enum.all?(players_with_status, fn player -> player.code == 200 end) do
      true -> true
      false -> %{error: players_with_status}
    end
  end

  def requester(url) do
    headers = [
      "X-Riot-Token": "RGAPI-d49cd0fb-3d72-480e-8636-ce1c4c5af197",
      Accept: "Application/json; Charset=utf-8"
    ]

    HTTPoison.get!(url, headers).status_code
  end
end
