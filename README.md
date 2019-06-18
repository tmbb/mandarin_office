# MandarinOffice

Sequence of commands needed to generate this app:

1. `mix phx.new mandarin_office`
2. Add `:mandarin` to the deps
3. `mix deps.get`
4. Install a new `Admin` context `mix mandarin.install Admin` (you can have as many mandarin-generated contexts as you want). This will:
  1. Inject code into your `router.ex` file (to add a new pipeline and scope)
  1. Inject code into your `repo.ex` file (to support pagination)
  1. Create a files for a new view and a new layout
5. Add a `Department` resource: `mix mandarin.gen.html Admin Department departments name:string --binary-id`
6. Add the routes under the `:admin` scope (using `Mandarin.Router.resources/2`)
7. Add a `Function` resource: `mix mandarin.gen.html Admin Department departments name:string --binary-id`
8. Add the routes under the `:admin` scope (using `Mandarin.Router.resources/2`)
9. Add an `Employee` resource: `mix mandarin.gen.html Admin Employee employees full_name:string address:string fiscal_number:string employee_number:integer department:references:departments function:references:functions begin_date:date end_date:date --binary-id`
10. Add the routes under the `:admin` scope (using `Mandarin.Router.resources/2`)
11. Add `:faker` to the deps (to generate some fake data)
12. Add the contents of the `seeds.exs` file from this github repo to your own `seeds.exs` file
13. Create and populate the database: `mix ecto.reset`
14. Start your application: `mix phx.server`

# More detailed explanation of the steps above

## 0. Overview

TODO

## 1. `mix phx.new mandarin_office`

Create a normal Phoenix project.
This requires Phoenix 1.4 so that the generated directory structure is compatible with these generators.

## 2. Add `:mandarin` to the deps

Although Mandarin is *mostly* made up from generators, in order to simplify the code, it contains some functions and macros that are needed at runtime and compile-time respectively.

## 3. `mix deps.get`

Self explanatory...

## 4. Install a new `Admin` context

Mandarin structures your admin functionality aroung Phoenix contexts.
Usually, your admin functionality would live in a single context, but you can have multiple admin contexts (with multiple templates, views, etc) if you want to.
Your app will remain blissfully unaware of the fact that some parts of it contain admin functionality; it's just a context like all others.

As the command line output explains, this will generate the admin layout view for you app.
It will also inject some code into your router and into you repo.

## Code injection in `router.ex`

The `mix mandarin.install Admin` command will inject the following code into the `router.ex` file:

```elixir
  require Mandarin.Router

  pipeline :admin_layout do
    plug(:put_layout, {MandarinOfficeWeb.AdminLayoutView, "layout.html"})
  end

  scope "/admin", MandarinOfficeWeb.Admin, as: :admin do
    pipe_through([:browser, :admin_layout])
    # Add your routes here
  end
```

You're supposed to add your routes inside the `:admin` scope.

## Code injection in `repo.ex`

It will inject the following code into the `repo.ex` file:

```elixir
  use Paginator
```

This will add support for pagination in your Repo (using the [:paginator]() package)
This defines a `paginate()` function in your `Repo` module, which is not the ideal behavior, but it's the only way to use `:paginator` with an Ecto repo, as far as I know.


## 5-10. Add the resources and routes

### Schema explanation

This app will model a company, which has *employees*.
Employees have *functions* and belong to *departments*.

Each `Employee` has a single `Function` and belongs to a single `Department`.
Currently one-to-many and many-to-many relations are supported.
MAndarin doesn't support many-to-many relationships yet.

### Create resources

The `mix mandarin.gen.html` command works exactly like the `mix phx.gen.html` command.
The arguments are the same.
The only difference is that the generated files are a little different.

Besides containing an Ecto schema (with some custom functions added to the module),
they also contain the implementation for the `ForageWeb.Display` protocol.
It's questionable whether a context should implement a display protocol for the web interface of the application, but it's probably the most natural place to put this.
Implementing the protocol somewhere else would bring even more fragmentation to the code.
I think the small amount of coupling that this introduces is worth it.

### Add the resources to the routes

To add the resources to the router, you can use the `Mandarin.Router.resources/2` macro.
This will add all the necessary actions for the app to work, including the `:select` action, which is used by the smart select widgets supported by forage.

You should add the routes under the `:admin` scope.
For example:

```elixir
  require Mandarin.Router

  pipeline :admin_layout do
    plug(:put_layout, {MandarinOfficeWeb.AdminLayoutView, "layout.html"})
  end

  scope "/admin", MandarinOfficeWeb.Admin, as: :admin do
    pipe_through([:browser, :admin_layout])
    # Add your routes here
    Mandarin.Router.resources("/employee", EmployeeController)
    Mandarin.Router.resources("/function", FunctionController)
    Mandarin.Router.resources("/department", DepartmentController)
  end
```

## 11. Add `:faker` to the deps

This package allows us to generate convincingly sounding fake data for demo purposes.

## 12. Add some code to the `seeds.exs` file to populate your database with fake data

The `seeds.exs` file for this project is the following (with glorious Warhammer 40k references!):

```elixir
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
```

## 13. Create and populate your database

Self explanatory.

## 14. Run your app

Finally, start your app and explore.

The relevant URLs are:

* `localhost:4000/admin/employee`
* `localhost:4000/admin/function`
* `localhost:4000/admin/department`

The URL `localhost:4000/admin` doesn't have default page.
Maybe it should.