# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MandarinOffice.Repo.insert!(%MandarinOffice.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias MandarinOffice.Admin

department_names = [
  "Adeptus Astartes",
  "Astra Militarum",
  "Ordo Xenos",
  "Ordo Malleus",
  "Ordo Hereticus"
]

departments =
  for name <- department_names do
    {:ok, department} = Admin.create_department(%{name: name})
    department
  end

function_names = [
  "Space Marine",
  "Space Marine Scout",
  "Techpriest",
  "Inquisitor",
  "Clerk",
  "Guardsman",
  "Commisar",
  "Seargent"
]

functions =
  for name <- function_names do
    {:ok, function} = Admin.create_function(%{name: name})
    function
  end

min_date = ~D[2019-01-01]
max_date = ~D[1935-01-01]

for _ <- 1..10_000 do
  random = Enum.random([true, false])
  begin_date = Faker.Date.between(min_date, max_date)
  end_date = Faker.Date.between(begin_date, max_date)

  employee = %{
    full_name: Faker.Name.En.name(),
    address: Faker.Address.En.street_address(random),
    fiscal_number: Faker.Gov.Us.ssn(),
    employee_number: Enum.random(1..100_000),
    begin_date: begin_date,
    end_date: end_date,
    department_id: Enum.random(departments).id,
    function_id: Enum.random(functions).id
  }

  {:ok, _employee} = Admin.create_employee(employee)
end
