defmodule LeagueOfLegendsServiceWeb.PageController do
  use LeagueOfLegendsServiceWeb, :controller

  def index(conn, _params) do
    json(conn, conn.query_params)
  end

  def post(conn, _params) do
    json(conn, conn.body_params)
  end
end
