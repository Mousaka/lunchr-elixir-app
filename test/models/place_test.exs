defmodule Luncher.PlaceTest do
  use Luncher.ModelCase

  alias Luncher.Place

  @valid_attrs %{cuisine: "some content", name: "some content", rating: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Place.changeset(%Place{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Place.changeset(%Place{}, @invalid_attrs)
    refute changeset.valid?
  end
end
