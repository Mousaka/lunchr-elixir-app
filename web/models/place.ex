defmodule Luncher.Place do
  use Luncher.Web, :model

  schema "places" do
    field :name, :string
    field :cuisine, :string
    field :rating, :float

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :cuisine, :rating])
    |> validate_required([:name, :cuisine, :rating])
  end
end
