defmodule TicketAgent.TeacherContext do
  @moduledoc """
  The Teachers context.
  """
  import Ecto.Query, warn: false
  alias TicketAgent.{Repo, Teacher}
  @doc """
  Returns the list of teachers.

  ## Examples

      iex> list_teachers()
      [%Context{}, ...]

  """
  def list_teachers do
    Repo.all(Teacher)
  end

  # @doc """
  # Gets a single context.
  #
  # Raises `Ecto.NoResultsError` if the Context does not exist.
  #
  # ## Examples
  #
  #     iex> get_context!(123)
  #     %Context{}
  #
  #     iex> get_context!(456)
  #     ** (Ecto.NoResultsError)
  #
  # """
  # def get_context!(id), do: Repo.get!(Context, id)
  #
  # @doc """
  # Creates a context.
  #
  # ## Examples
  #
  #     iex> create_context(%{field: value})
  #     {:ok, %Context{}}
  #
  #     iex> create_context(%{field: bad_value})
  #     {:error, %Ecto.Changeset{}}
  #
  # """
  # def create_context(attrs \\ %{}) do
  #   %Context{}
  #   |> Context.changeset(attrs)
  #   |> Repo.insert()
  # end
  #
  # @doc """
  # Updates a context.
  #
  # ## Examples
  #
  #     iex> update_context(context, %{field: new_value})
  #     {:ok, %Context{}}
  #
  #     iex> update_context(context, %{field: bad_value})
  #     {:error, %Ecto.Changeset{}}
  #
  # """
  # def update_context(%Context{} = context, attrs) do
  #   context
  #   |> Context.changeset(attrs)
  #   |> Repo.update()
  # end
  #
  # @doc """
  # Deletes a Context.
  #
  # ## Examples
  #
  #     iex> delete_context(context)
  #     {:ok, %Context{}}
  #
  #     iex> delete_context(context)
  #     {:error, %Ecto.Changeset{}}
  #
  # """
  # def delete_context(%Context{} = context) do
  #   Repo.delete(context)
  # end
  #
  # @doc """
  # Returns an `%Ecto.Changeset{}` for tracking context changes.
  #
  # ## Examples
  #
  #     iex> change_context(context)
  #     %Ecto.Changeset{source: %Context{}}
  #
  # """
  # def change_context(%Context{} = context) do
  #   Context.changeset(context, %{})
  # end
end
