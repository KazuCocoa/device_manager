defmodule DeviceManager.PageController do
  use DeviceManager.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
