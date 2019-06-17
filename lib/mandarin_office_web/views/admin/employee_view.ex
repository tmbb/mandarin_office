defmodule MandarinOfficeWeb.Admin.EmployeeView do
  use MandarinOfficeWeb, :view
  alias MandarinOffice.Admin.Department

  alias MandarinOffice.Admin.Function

  use ForageWeb.ForageView,
    routes_module: Routes,
    prefix: :admin_employee
end