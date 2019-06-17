defmodule MandarinOffice.AdminTest do
  use MandarinOffice.DataCase

  alias MandarinOffice.Admin

  describe "functions" do
    alias MandarinOffice.Admin.Function

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def function_fixture(attrs \\ %{}) do
      {:ok, function} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_function()

      function
    end

    test "list_functions/0 returns all functions" do
      function = function_fixture()
      assert Admin.list_functions() == [function]
    end

    test "get_function!/1 returns the function with given id" do
      function = function_fixture()
      assert Admin.get_function!(function.id) == function
    end

    test "create_function/1 with valid data creates a function" do
      assert {:ok, %Function{} = function} = Admin.create_function(@valid_attrs)
      assert function.name == "some name"
    end

    test "create_function/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_function(@invalid_attrs)
    end

    test "update_function/2 with valid data updates the function" do
      function = function_fixture()
      assert {:ok, %Function{} = function} = Admin.update_function(function, @update_attrs)
      
      assert function.name == "some updated name"
    end

    test "update_function/2 with invalid data returns error changeset" do
      function = function_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_function(function, @invalid_attrs)
      assert function == Admin.get_function!(function.id)
    end

    test "delete_function/1 deletes the function" do
      function = function_fixture()
      assert {:ok, %Function{}} = Admin.delete_function(function)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_function!(function.id) end
    end

    test "change_function/1 returns a function changeset" do
      function = function_fixture()
      assert %Ecto.Changeset{} = Admin.change_function(function)
    end
  end

  describe "departments" do
    alias MandarinOffice.Admin.Department

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def department_fixture(attrs \\ %{}) do
      {:ok, department} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_department()

      department
    end

    test "list_departments/0 returns all departments" do
      department = department_fixture()
      assert Admin.list_departments() == [department]
    end

    test "get_department!/1 returns the department with given id" do
      department = department_fixture()
      assert Admin.get_department!(department.id) == department
    end

    test "create_department/1 with valid data creates a department" do
      assert {:ok, %Department{} = department} = Admin.create_department(@valid_attrs)
      assert department.name == "some name"
    end

    test "create_department/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_department(@invalid_attrs)
    end

    test "update_department/2 with valid data updates the department" do
      department = department_fixture()
      assert {:ok, %Department{} = department} = Admin.update_department(department, @update_attrs)
      
      assert department.name == "some updated name"
    end

    test "update_department/2 with invalid data returns error changeset" do
      department = department_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_department(department, @invalid_attrs)
      assert department == Admin.get_department!(department.id)
    end

    test "delete_department/1 deletes the department" do
      department = department_fixture()
      assert {:ok, %Department{}} = Admin.delete_department(department)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_department!(department.id) end
    end

    test "change_department/1 returns a department changeset" do
      department = department_fixture()
      assert %Ecto.Changeset{} = Admin.change_department(department)
    end
  end

  describe "employees" do
    alias MandarinOffice.Admin.Employee

    @valid_attrs %{address: "some address", begin_date: ~D[2010-04-17], employee_number: 42, end_date: ~D[2010-04-17], fiscal_number: "some fiscal_number", full_name: "some full_name"}
    @update_attrs %{address: "some updated address", begin_date: ~D[2011-05-18], employee_number: 43, end_date: ~D[2011-05-18], fiscal_number: "some updated fiscal_number", full_name: "some updated full_name"}
    @invalid_attrs %{address: nil, begin_date: nil, employee_number: nil, end_date: nil, fiscal_number: nil, full_name: nil}

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_employee()

      employee
    end

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Admin.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Admin.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = Admin.create_employee(@valid_attrs)
      assert employee.address == "some address"
      assert employee.begin_date == ~D[2010-04-17]
      assert employee.employee_number == 42
      assert employee.end_date == ~D[2010-04-17]
      assert employee.fiscal_number == "some fiscal_number"
      assert employee.full_name == "some full_name"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{} = employee} = Admin.update_employee(employee, @update_attrs)
      
      assert employee.address == "some updated address"
      assert employee.begin_date == ~D[2011-05-18]
      assert employee.employee_number == 43
      assert employee.end_date == ~D[2011-05-18]
      assert employee.fiscal_number == "some updated fiscal_number"
      assert employee.full_name == "some updated full_name"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_employee(employee, @invalid_attrs)
      assert employee == Admin.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Admin.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Admin.change_employee(employee)
    end
  end
end
