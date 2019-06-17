defmodule MandarinOfficeWeb.Admin.DepartmentController do
  use MandarinOfficeWeb, :controller

  alias MandarinOffice.Admin
  alias MandarinOffice.Admin.Department
  alias ForageWeb.ForageController

  # Adds the the resource type to the conn
  plug(Mandarin.Plugs.Resource, :department)

  def index(conn, params) do
    departments = Admin.list_departments(params)
    render(conn, "index.html", departments: departments)
  end

  def new(conn, _params) do
    changeset = Admin.change_department(%Department{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"department" => department_params}) do
    case Admin.create_department(department_params) do
      {:ok, department} ->
        conn
        |> put_flash(:info, "Department created successfully.")
        |> redirect(to: Routes.admin_department_path(conn, :show, department))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    department = Admin.get_department!(id)
    render(conn, "show.html", department: department)
  end

  def edit(conn, %{"id" => id}) do
    department = Admin.get_department!(id)
    changeset = Admin.change_department(department)
    render(conn, "edit.html", department: department, changeset: changeset)
  end

  def update(conn, %{"id" => id, "department" => department_params}) do
    department = Admin.get_department!(id)

    case Admin.update_department(department, department_params) do
      {:ok, department} ->
        conn
        |> put_flash(:info, "Department updated successfully.")
        |> redirect(to: Routes.admin_department_path(conn, :show, department))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", department: department, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id} = params) do
    department = Admin.get_department!(id)
    {:ok, _department} = Admin.delete_department(department)
    # After deleting, remain on the same page
    redirect_params = ForageController.pagination_from_params(params)

    conn
    |> put_flash(:info, "Department deleted successfully.")
    |> redirect(to: Routes.admin_department_path(conn, :index, redirect_params))
  end

  def select(conn, params) do
    departments = Admin.list_departments(params)
    data = ForageController.forage_select_data(departments)
    json(conn, data)
  end
end