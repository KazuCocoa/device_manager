defmodule DeviceManager.DeviceController do
  use DeviceManager.Web, :controller

  alias DeviceManager.Device
  alias DeviceManager.User

  plug :scrub_params, "device" when action in [:create, :update]

  def index(conn, _params) do
    devices = Repo.all(Device)
              |> Repo.preload(:user)
    render(conn, "index.html", devices: devices)
  end

  def new(conn, _params) do
    changeset = Device.changeset(%Device{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"device" => device_params}) do
    changeset = Device.changeset(%Device{}, device_params)

    if changeset.valid? do
      Repo.transaction(fn->
        device = Repo.insert!(changeset)
        user = Repo.insert! %User{device_id: device.id, user_name: "your name", user_sex: "male"}
        device = Repo.update! %Device{device | user: user}
      end)

      conn
      |> put_flash(:info, "Device created successfully.")
      |> redirect(to: device_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    device = Repo.get!(Device, id)
    render(conn, "show.html", device: device)
  end

  def edit(conn, %{"id" => id}) do
    device = Repo.get!(Device, id)
    changeset = Device.changeset(device)
    render(conn, "edit.html", device: device, changeset: changeset)
  end

  def update(conn, %{"id" => id, "device" => device_params}) do
    device = Repo.get!(Device, id)
    changeset = Device.changeset(device, device_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "Device updated successfully.")
      |> redirect(to: device_path(conn, :index))
    else
      render(conn, "edit.html", device: device, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    device = Repo.get!(Device, id)
             |> Repo.preload(:user)
    user = Repo.get!(User, device.user.id)
    Repo.transaction(fn->
      Repo.delete!(device)
      Repo.delete!(user)
    end)

    conn
    |> put_flash(:info, "Device deleted successfully.")
    |> redirect(to: device_path(conn, :index))
  end
end
