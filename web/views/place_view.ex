defmodule Luncher.PlaceView do
  use Luncher.Web, :view

  def render("index.json", %{places: places}) do
    %{data: render_many(places, Luncher.PlaceView, "place.json")}
  end

  def render("show.json", %{place: place}) do
    %{data: render_one(place, Luncher.PlaceView, "place.json")}
  end

  def render("place.json", %{place: place}) do
    %{id: place.id,
      name: place.name,
      cuisine: place.cuisine,
      rating: place.rating}
  end
end
