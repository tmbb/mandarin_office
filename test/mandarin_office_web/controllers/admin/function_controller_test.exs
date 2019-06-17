defmodule MandarinOfficeWeb."Admin".FunctionControllerTest do
  use MandarinOfficeWeb.ConnCase

  alias MandarinOffice.Admin

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:function) do
    {:ok, function} = Admin.create_function(@create_attrs)
    function
  end

  describe "index" do
    test "lists all functions", %{conn: conn} do
      conn = get conn, Routes.admin_function_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Functions"
    end
  end

  describe "new function" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.admin_function_path(conn, :new)
      assert html_response(conn, 200) =~ "New Function"
    end
  end

  describe "create function" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.admin_function_path(conn, :create), function: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_function_path(conn, :show, id)

      conn = get conn, Routes.admin_function_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Function"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.admin_function_path(conn, :create), function: @invalid_attrs
      assert html_response(conn, 200) =~ "New Function"
    end
  end

  describe "edit function" do
    setup [:create_function]

    test "renders form for editing chosen function", %{conn: conn, function: function} do
      conn = get conn, Routes.admin_function_path(conn, :edit, function)
      assert html_response(conn, 200) =~ "Edit Function"
    end
  end

  describe "update function" do
    setup [:create_function]

    test "redirects when data is valid", %{conn: conn, function: function} do
      conn = put conn, Routes.admin_function_path(conn, :update, function), function: @update_attrs
      assert redirected_to(conn) == Routes.admin_function_path(conn, :show, function)

      conn = get conn, Routes.admin_function_path(conn, :show, function)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, function: function} do
      conn = put conn, Routes.admin_function_path(conn, :update, function), function: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Function"
    end
  end

  describe "delete function" do
    setup [:create_function]

    test "deletes chosen function", %{conn: conn, function: function} do
      conn = delete conn, Routes.admin_function_path(conn, :delete, function)
      assert redirected_to(conn) == Routes.admin_function_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.admin_function_path(conn, :show, function)
      end
    end
  end

  defp create_function(_) do
    function = fixture(:function)
    {:ok, function: function}
  end
end
