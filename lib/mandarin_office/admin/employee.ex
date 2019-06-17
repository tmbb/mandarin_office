defmodule MandarinOffice.Admin.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "employees" do
    field(:address, :string)
    field(:begin_date, :date)
    field(:employee_number, :integer)
    field(:end_date, :date)
    field(:fiscal_number, :string)
    field(:full_name, :string)
    belongs_to(:department, MandarinOffice.Admin.Department, on_replace: :nilify)
    belongs_to(:function, MandarinOffice.Admin.Function, on_replace: :nilify)

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [
      :full_name,
      :address,
      :fiscal_number,
      :employee_number,
      :begin_date,
      :end_date,
      :department_id,
      :function_id
    ])
    |> validate_required([
      :full_name,
      :address,
      :fiscal_number,
      :employee_number,
      :begin_date,
      :end_date
    ])
    |> cast_assoc(:department)
    |> cast_assoc(:function)
  end

  def select_search_field() do
    :full_name
  end
end

defimpl ForageWeb.Display, for: MandarinOffice.Admin.Employee do
  def display(employee) do
    "#{employee.full_name}"
  end
end