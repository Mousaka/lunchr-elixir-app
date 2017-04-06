defmodule Luncher.Repo.Migrations.CreateRat do
  use Ecto.Migration

  def change do
    create table(:rats) do
      add :rating, :integer
      add :places_id, references(:places, on_delete: :nothing)

      timestamps()
    end
    create index(:rats, [:places_id])

  end
end
