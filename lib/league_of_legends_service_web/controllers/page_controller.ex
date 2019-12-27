defmodule LeagueOfLegendsServiceWeb.PageController do
  use LeagueOfLegendsServiceWeb, :controller
  alias LeagueOfLegendsService.Validation.Validation

  def index(conn, _params) do
    json(conn, conn.query_params)
  end

  def post(conn, _params) do
    request_params = Plug.Conn.read_body(conn) |> elem(1) |> Poison.decode!()

    case Validation.validation_for_create_tournament(request_params) do
      true -> json(conn, true)
      {:error, error} -> json(conn, error)
    end
  end
end
