defmodule Luncher.RatControllerTest do
  use Luncher.ConnCase

  alias Luncher.Rat
  @valid_attrs %{rating: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, rat_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    rat = Repo.insert! %Rat{}
    conn = get conn, rat_path(conn, :show, rat)
    assert json_response(conn, 200)["data"] == %{"id" => rat.id,
      "places_id" => rat.places_id,
      "rating" => rat.rating}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, rat_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, rat_path(conn, :create), rat: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Rat, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, rat_path(conn, :create), rat: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    rat = Repo.insert! %Rat{}
    conn = put conn, rat_path(conn, :update, rat), rat: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Rat, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    rat = Repo.insert! %Rat{}
    conn = put conn, rat_path(conn, :update, rat), rat: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    rat = Repo.insert! %Rat{}
    conn = delete conn, rat_path(conn, :delete, rat)
    assert response(conn, 204)
    refute Repo.get(Rat, rat.id)
  end
end
