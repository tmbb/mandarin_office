defmodule MandarinOfficeWeb."Admin".DepartmentControllerTest do
  use MandarinOfficeWeb.ConnCase

  alias MandarinOffice.Admin

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:department) do
    {:ok, department} = Admin.create_department(@create_attrs)
    department
  end

  describe "index" do
    test "lists all departments", %{conn: conn} do
      conn = get conn, Routes.admin_department_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Departments"
    end
  end

  describe "new department" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.admin_department_path(conn, :new)
      assert html_response(conn, 200) =~ "New Department"
    end
  end

  describe "create department" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.admin_department_path(conn, :create), department: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_department_path(conn, :show, id)

      conn = get conn, Routes.admin_department_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Department"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.admin_department_path(conn, :create), department: @invalid_attrs
      assert html_response(conn, 200) =~ "New Department"
    end
  end

  describe "edit department" do
    setup [:create_department]

    test "renders form for editing chosen department", %{conn: conn, department: department} do
      conn = get conn, Routes.admin_department_path(conn, :edit, department)
      assert html_response(conn, 200) =~ "Edit Department"
    end
  end

  describe "update department" do
    setup [:create_department]

    test "redirects when data is valid", %{conn: conn, department: department} do
      conn = put conn, Routes.admin_department_path(conn, :update, department), department: @update_attrs
      assert redirected_to(conn) == Routes.admin_department_path(conn, :show, department)

      conn = get conn, Routes.admin_department_path(conn, :show, department)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, department: department} do
      conn = put conn, Routes.admin_department_path(conn, :update, department), department: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Department"
    end
  end

  describe "delete department" do
    setup [:create_department]

    test "deletes chosen department", %{conn: conn, department: department} do
      conn = delete conn, Routes.admin_department_path(conn, :delete, department)
      assert redirected_to(conn) == Routes.admin_department_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.admin_department_path(conn, :show, department)
      end
    end
  end

  defp create_department(_) do
    department = fixture(:department)
    {:ok, department: department}
  end
end
