defmodule DeviceManager.RentalController do
  use DeviceManager.Web, :controller

  alias DeviceManager.Rental

  plug :scrub_params, "rental" when action in [:create, :update]

  def index(conn, _params) do
    rental = Repo.all(Rental)
    render(conn, "index.json", rental: rental)
  end

  def create(conn, %{"rental" => rental_params}) do
    changeset = Rental.changeset(%Rental{}, rental_params)

    if changeset.valid? do
      rental = Repo.insert!(changeset)
      render(conn, "show.json", rental: rental)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(DeviceManager.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    rental = Repo.get!(Rental, id)
    render conn, "show.json", rental: rental
  end

  def update(conn, %{"id" => id, "rental" => rental_params}) do
    rental = Repo.get!(Rental, id)
    changeset = Rental.changeset(rental, rental_params)

    if changeset.valid? do
      rental = Repo.update!(changeset)
      render(conn, "show.json", rental: rental)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(DeviceManager.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    rental = Repo.get!(Rental, id)

    rental = Repo.delete!(rental)
    render(conn, "show.json", rental: rental)
  end
end
