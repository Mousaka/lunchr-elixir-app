defmodule Luncher.Rat do
  use Luncher.Web, :model

  schema "rats" do
    field :rating, :integer
    belongs_to :places, Luncher.Places

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:rating])
    |> validate_required([:rating])
  end
end
