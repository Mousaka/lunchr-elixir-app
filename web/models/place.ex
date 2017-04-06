defmodule Luncher.Place do
  use Luncher.Web, :model

  schema "places" do
    field :name, :string
    field :cuisine, :string
    field :rating, :float

    timestamps()
  end

  def thai(query) do
    from var in query,
      where: var.cuisine == "thai"
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
