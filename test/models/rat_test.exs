defmodule Luncher.RatTest do
  use Luncher.ModelCase

  alias Luncher.Rat

  @valid_attrs %{rating: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Rat.changeset(%Rat{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Rat.changeset(%Rat{}, @invalid_attrs)
    refute changeset.valid?
  end
end
