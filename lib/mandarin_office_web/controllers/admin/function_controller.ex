defmodule MandarinOfficeWeb.Admin.FunctionController do
  use MandarinOfficeWeb, :controller

  alias MandarinOffice.Admin
  alias MandarinOffice.Admin.Function
  alias ForageWeb.ForageController

  # Adds the the resource type to the conn
  plug(Mandarin.Plugs.Resource, :function)

  def index(conn, params) do
    functions = Admin.list_functions(params)
    render(conn, "index.html", functions: functions)
  end

  def new(conn, _params) do
    changeset = Admin.change_function(%Function{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"function" => function_params}) do
    case Admin.create_function(function_params) do
      {:ok, function} ->
        conn
        |> put_flash(:info, "Function created successfully.")
        |> redirect(to: Routes.admin_function_path(conn, :show, function))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    function = Admin.get_function!(id)
    render(conn, "show.html", function: function)
  end

  def edit(conn, %{"id" => id}) do
    function = Admin.get_function!(id)
    changeset = Admin.change_function(function)
    render(conn, "edit.html", function: function, changeset: changeset)
  end

  def update(conn, %{"id" => id, "function" => function_params}) do
    function = Admin.get_function!(id)

    case Admin.update_function(function, function_params) do
      {:ok, function} ->
        conn
        |> put_flash(:info, "Function updated successfully.")
        |> redirect(to: Routes.admin_function_path(conn, :show, function))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", function: function, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id} = params) do
    function = Admin.get_function!(id)
    {:ok, _function} = Admin.delete_function(function)
    # After deleting, remain on the same page
    redirect_params = ForageController.pagination_from_params(params)

    conn
    |> put_flash(:info, "Function deleted successfully.")
    |> redirect(to: Routes.admin_function_path(conn, :index, redirect_params))
  end

  def select(conn, params) do
    functions = Admin.list_functions(params)
    data = ForageController.forage_select_data(functions)
    json(conn, data)
  end
end