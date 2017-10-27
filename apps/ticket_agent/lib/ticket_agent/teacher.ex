defmodule TicketAgent.Teacher do
  @moduledoc false
  use TicketAgent.Schema
  alias TicketAgent.Atomizer

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "teachers" do
    field :slug, :string
    field :biography, :string
    field :email, :string
    field :name, :string
    field :social, :map
    timestamps()
  end

  @doc false
  # def changeset(%{} = class, attrs) do
  def changeset(%Teacher{} = class, attrs) do
    slug = load_slug(attrs)
    attrs = Map.put(attrs, "slug", slug)
    class
    |> cast(attrs, [:slug, :biography, :email, :name, :social])
    |> validate_required([:name, :email])
  end

  defp load_slug(%{"slug" => slug} = attrs), do: slug
  defp load_slug(%{slug: slug} = attrs), do: slug

  defp load_slug(%{"name" => name, "slug" => nil} = attrs) do
    generate_slug(name)
  end
  defp load_slug(%{name: name, slug: nil} = attrs) do
    generate_slug(name)
  end
  defp load_slug(attrs) do
    ""
  end
  defp generate_slug(name) do
    String.split(name, " ") |> hd |> String.downcase
  end
end
