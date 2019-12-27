defmodule LeagueOfLegendsService.Request.Requester do
  @base_url "https://la2.api.riotgames.com/lol/"
  @api_key "RGAPI-03eb59ef-f5f5-4da6-8c72-b8c2b8d9e89f"

  def requester_for_get_player_status_code(endpoint, name) do
    url = @base_url <> endpoint <> "#{name}"

    headers = [
      "X-Riot-Token": @api_key,
      Accept: "Application/json; Charset=utf-8"
    ]

    HTTPoison.get!(url, headers).status_code
  end
end
