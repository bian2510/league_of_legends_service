defmodule LeagueOfLegendsService.Request.Receiver do
  def send_request(params) do
    players = params["data"]["players"]    
    Enum.map(players, fn player -> LeagueOfLegendsService.Request.Validation.exist_player?(player)end)
  end
end