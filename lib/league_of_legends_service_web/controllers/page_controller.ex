defmodule LeagueOfLegendsServiceWeb.PageController do
  use LeagueOfLegendsServiceWeb, :controller

  def index(conn, _params) do
    json(conn, conn.query_params)
  end

  def post(conn, _params) do
    request_params = Plug.Conn.read_body(conn) |> elem(1) |> Poison.decode!()
    json(conn, LeagueOfLegendsService.Request.Receiver.send_request(request_params))
  end
end
