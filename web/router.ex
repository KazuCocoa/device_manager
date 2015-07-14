defmodule DeviceManager.Router do
  use DeviceManager.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DeviceManager do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    # forward "/", DeviceController, :index
    resources "/devices", DeviceController
  end

  # Other scopes may use custom stacks.
  scope "/api", DeviceManager do
    pipe_through :api
    resources "/rental", RentalController
  end
end
