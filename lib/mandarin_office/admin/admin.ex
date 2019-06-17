defmodule MandarinOffice.Admin do
  @moduledoc """
  The Admin context.
  """

  import Ecto.Query, warn: false
  alias MandarinOffice.Repo
  alias Forage

  alias MandarinOffice.Admin.Function

  @doc """
  Returns a filtered list of functions.

  The list is filtered by `params["_search"]`, sorted by `params["_sort"]
  and paginated according to `params["_pagination"].

  ## Examples

      iex> list_functions(params)
      [%Function{}, ...]

  """
  def list_functions(params) do
    Forage.paginate(params, Function, Repo, sort: [:name, :id], preload: [])
  end

  @doc """
  Gets a single function.

  Raises `Ecto.NoResultsError` if the Function does not exist.

  ## Examples

      iex> get_function!(123)
      %Function{}

      iex> get_function!(456)
      ** (Ecto.NoResultsError)

  """
  def get_function!(id), do: Repo.get!(Function, id) |> Repo.preload([])

  @doc """
  Creates a function.

  ## Examples

      iex> create_function(%{field: value})
      {:ok, %Function{}}

      iex> create_function(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_function(attrs \\ %{}) do
    %Function{}
    |> Function.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a function.

  ## Examples

      iex> update_function(function, %{field: new_value})
      {:ok, %Function{}}

      iex> update_function(function, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_function(%Function{} = function, attrs) do
    function
    |> Function.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Function.

  ## Examples

      iex> delete_function(function)
      {:ok, %Function{}}

      iex> delete_function(function)
      {:error, %Ecto.Changeset{}}

  """
  def delete_function(%Function{} = function) do
    Repo.delete(function)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking function changes.

  ## Examples

      iex> change_function(function)
      %Ecto.Changeset{source: %Function{}}

  """
  def change_function(%Function{} = function) do
    Function.changeset(function, %{})
  end

  alias MandarinOffice.Admin.Department

  @doc """
  Returns a filtered list of departments.

  The list is filtered by `params["_search"]`, sorted by `params["_sort"]
  and paginated according to `params["_pagination"].

  ## Examples

      iex> list_departments(params)
      [%Department{}, ...]

  """
  def list_departments(params) do
    Forage.paginate(params, Department, Repo, sort: [:name, :id], preload: [])
  end

  @doc """
  Gets a single department.

  Raises `Ecto.NoResultsError` if the Department does not exist.

  ## Examples

      iex> get_department!(123)
      %Department{}

      iex> get_department!(456)
      ** (Ecto.NoResultsError)

  """
  def get_department!(id), do: Repo.get!(Department, id) |> Repo.preload([])

  @doc """
  Creates a department.

  ## Examples

      iex> create_department(%{field: value})
      {:ok, %Department{}}

      iex> create_department(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_department(attrs \\ %{}) do
    %Department{}
    |> Department.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a department.

  ## Examples

      iex> update_department(department, %{field: new_value})
      {:ok, %Department{}}

      iex> update_department(department, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_department(%Department{} = department, attrs) do
    department
    |> Department.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Department.

  ## Examples

      iex> delete_department(department)
      {:ok, %Department{}}

      iex> delete_department(department)
      {:error, %Ecto.Changeset{}}

  """
  def delete_department(%Department{} = department) do
    Repo.delete(department)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking department changes.

  ## Examples

      iex> change_department(department)
      %Ecto.Changeset{source: %Department{}}

  """
  def change_department(%Department{} = department) do
    Department.changeset(department, %{})
  end

  alias MandarinOffice.Admin.Employee

  @doc """
  Returns a filtered list of employees.

  The list is filtered by `params["_search"]`, sorted by `params["_sort"]
  and paginated according to `params["_pagination"].

  ## Examples

      iex> list_employees(params)
      [%Employee{}, ...]

  """
  def list_employees(params) do
    Forage.paginate(params, Employee, Repo, sort: [:full_name, :id], preload: [:department, :function])
  end

  @doc """
  Gets a single employee.

  Raises `Ecto.NoResultsError` if the Employee does not exist.

  ## Examples

      iex> get_employee!(123)
      %Employee{}

      iex> get_employee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_employee!(id), do: Repo.get!(Employee, id) |> Repo.preload([:department, :function])

  @doc """
  Creates a employee.

  ## Examples

      iex> create_employee(%{field: value})
      {:ok, %Employee{}}

      iex> create_employee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_employee(attrs \\ %{}) do
    %Employee{}
    |> Employee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a employee.

  ## Examples

      iex> update_employee(employee, %{field: new_value})
      {:ok, %Employee{}}

      iex> update_employee(employee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_employee(%Employee{} = employee, attrs) do
    employee
    |> Employee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Employee.

  ## Examples

      iex> delete_employee(employee)
      {:ok, %Employee{}}

      iex> delete_employee(employee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_employee(%Employee{} = employee) do
    Repo.delete(employee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking employee changes.

  ## Examples

      iex> change_employee(employee)
      %Ecto.Changeset{source: %Employee{}}

  """
  def change_employee(%Employee{} = employee) do
    Employee.changeset(employee, %{})
  end
end
