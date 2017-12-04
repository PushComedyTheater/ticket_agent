defmodule TicketAgent.Teacher do
  use TicketAgent.Schema
  alias TicketAgent.Atomizer

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "teachers" do
    field :slug, :string
    field :name, :string
    field :email, :string
    field :biography, :string    
    field :social, :map
    timestamps()
  end

  @doc false
  def changeset(%Teacher{} = class, attrs) do
    slug = generate_teacher_slug(attrs)

    attrs = Atomizer.atomize(attrs)

    attrs =
      attrs
      |> Map.put(:slug, slug)
      |> Map.put_new(:social, %{})

    class
    |> cast(attrs, [:slug, :biography, :email, :name, :social])
    |> validate_required([:name, :email])
  end

  def generate_teacher_slug(attrs) do
    Map.get_lazy(attrs, "name", fn() -> Map.get(attrs, :name, "") end)
    |> String.split(" ")
    |> hd
    |> String.downcase
  end
end
