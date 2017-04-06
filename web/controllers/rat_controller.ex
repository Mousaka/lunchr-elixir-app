defmodule Luncher.RatController do
  use Luncher.Web, :controller

  alias Luncher.Rat

  def index(conn, _params) do
    rats = Repo.all(Rat)
    render(conn, "index.json", rats: rats)
  end

  def create(conn, %{"rat" => rat_params}) do
    changeset = Rat.changeset(%Rat{}, rat_params)

    case Repo.insert(changeset) do
      {:ok, rat} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", rat_path(conn, :show, rat))
        |> render("show.json", rat: rat)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Luncher.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    rat = Repo.get!(Rat, id)
    render(conn, "show.json", rat: rat)
  end

  def update(conn, %{"id" => id, "rat" => rat_params}) do
    rat = Repo.get!(Rat, id)
    changeset = Rat.changeset(rat, rat_params)

    case Repo.update(changeset) do
      {:ok, rat} ->
        render(conn, "show.json", rat: rat)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Luncher.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    rat = Repo.get!(Rat, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(rat)

    send_resp(conn, :no_content, "")
  end
end
