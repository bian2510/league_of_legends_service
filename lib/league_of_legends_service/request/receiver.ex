defmodule LeagueOfLegendsService.Request.Receiver do
  alias LeagueOfLegendsService.Request.Validation

  def send_request(params) do
    case Validation.validation_for_create_tournament(params) do
      true -> true
      {:error, error} -> error
    end
  end
end
