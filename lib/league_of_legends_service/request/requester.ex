defmodule LeagueOfLegendsService.Request.Requester do
  @base_url_supplier "https://la2.api.riotgames.com/lol/"
  @api_key "RGAPI-36062f3f-1616-4374-ac29-5688cf842b7a"
  @base_url_tournament "http://localhost:4002/"
  def request_for_get_player_status_code(name) do
    url = @base_url_supplier <> "summoner/v4/summoners/by-name/#{name}"

    headers = [
      "X-Riot-Token": @api_key,
      Accept: "Application/json; Charset=utf-8"
    ]

    HTTPoison.get!(url, headers).status_code
  end

  def request_for_create_tournament(params) do
    HTTPoison.post!(@base_url_tournament, params).body |> Poison.decode!()
  end
end
