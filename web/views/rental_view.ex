defmodule DeviceManager.RentalView do
  use DeviceManager.Web, :view

  def render("index.json", %{rental: rental}) do
    %{data: render_many(rental, "rental.json")}
  end

  def render("show.json", %{rental: rental}) do
    %{data: render_one(rental, "rental.json")}
  end

  def render("rental.json", %{rental: rental}) do
    %{id: rental.id}
  end
end
