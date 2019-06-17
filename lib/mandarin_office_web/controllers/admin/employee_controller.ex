defmodule MandarinOfficeWeb.Admin.EmployeeController do
  use MandarinOfficeWeb, :controller

  alias MandarinOffice.Admin
  alias MandarinOffice.Admin.Employee
  alias ForageWeb.ForageController

  # Adds the the resource type to the conn
  plug(Mandarin.Plugs.Resource, :employee)

  def index(conn, params) do
    employees = Admin.list_employees(params)
    render(conn, "index.html", employees: employees)
  end

  def new(conn, _params) do
    changeset = Admin.change_employee(%Employee{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"employee" => employee_params}) do
    case Admin.create_employee(employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Employee created successfully.")
        |> redirect(to: Routes.admin_employee_path(conn, :show, employee))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    employee = Admin.get_employee!(id)
    render(conn, "show.html", employee: employee)
  end

  def edit(conn, %{"id" => id}) do
    employee = Admin.get_employee!(id)
    changeset = Admin.change_employee(employee)
    render(conn, "edit.html", employee: employee, changeset: changeset)
  end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    employee = Admin.get_employee!(id)

    case Admin.update_employee(employee, employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Employee updated successfully.")
        |> redirect(to: Routes.admin_employee_path(conn, :show, employee))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", employee: employee, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id} = params) do
    employee = Admin.get_employee!(id)
    {:ok, _employee} = Admin.delete_employee(employee)
    # After deleting, remain on the same page
    redirect_params = ForageController.pagination_from_params(params)

    conn
    |> put_flash(:info, "Employee deleted successfully.")
    |> redirect(to: Routes.admin_employee_path(conn, :index, redirect_params))
  end

  def select(conn, params) do
    employees = Admin.list_employees(params)
    data = ForageController.forage_select_data(employees)
    json(conn, data)
  end
end