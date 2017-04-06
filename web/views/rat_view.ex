defmodule Luncher.RatView do
  use Luncher.Web, :view

  def render("index.json", %{rats: rats}) do
    %{data: render_many(rats, Luncher.RatView, "rat.json")}
  end

  def render("show.json", %{rat: rat}) do
    %{data: render_one(rat, Luncher.RatView, "rat.json")}
  end

  def render("rat.json", %{rat: rat}) do
    %{id: rat.id,
      places_id: rat.places_id,
      rating: rat.rating}
  end
end
