defmodule LeagueOfLegendsServiceWeb.PageController do
  use LeagueOfLegendsServiceWeb, :controller
  alias LeagueOfLegendsService.Validation.Validation
  alias LeagueOfLegendsService.Request.Requester

  def index(conn, _params) do
    json(conn, conn.query_params)
  end

  def post(conn, _params) do
    params = Plug.Conn.read_body(conn) |> elem(1) |> Poison.decode!()
    request_params = params |> Poison.encode!()

    case Validation.validation_for_create_tournament(params) do
      true -> json(conn, Requester.request_for_create_tournament(request_params))
      {:error, error} -> json(conn, error)
    end
  end
end
