defmodule MothersDayWeb.PageController do
  use MothersDayWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def letter1(conn, _params), do: render(conn, :letter1, layout: false)
  def letter2(conn, _params), do: render(conn, :letter2, layout: false)
  def letter3(conn, _params), do: render(conn, :letter3, layout: false)
end
