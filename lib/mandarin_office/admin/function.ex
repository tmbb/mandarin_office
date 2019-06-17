defmodule MandarinOffice.Admin.Function do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "functions" do
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(function, attrs) do
    function
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def select_search_field() do
    :name
  end
end

defimpl ForageWeb.Display, for: MandarinOffice.Admin.Function do
  def display(function) do
    "#{function.name}"
  end
end