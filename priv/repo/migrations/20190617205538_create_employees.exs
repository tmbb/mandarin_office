defmodule MandarinOffice.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :full_name, :string
      add :address, :string
      add :fiscal_number, :string
      add :employee_number, :integer
      add :begin_date, :date
      add :end_date, :date
      add :department_id, references(:departments, on_delete: :nothing, type: :binary_id)
      add :function_id, references(:functions, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:employees, [:department_id])
    create index(:employees, [:function_id])
  end
end
