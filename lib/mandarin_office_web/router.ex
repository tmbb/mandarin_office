defmodule MandarinOfficeWeb.Router do
  use MandarinOfficeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MandarinOfficeWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MandarinOfficeWeb do
  #   pipe_through :api
  # end

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
end
