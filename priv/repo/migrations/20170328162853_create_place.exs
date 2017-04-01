defmodule Luncher.Repo.Migrations.CreatePlace do
  use Ecto.Migration

  def change do
    create table(:places) do
      add :name, :string
      add :cuisine, :string
      add :rating, :float

      timestamps()
    end

  end
end
