defmodule TicketAgent.User do
  @moduledoc false
  use TicketAgent.Schema
  use Coherence.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  @foreign_key_type :binary_id

  schema "users" do
    belongs_to :account, Account
    field :name, :string
    field :email, :string
    coherence_schema()
    field :role, :string
    field :stripe_customer_id, :string
    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :email, :account_id, :role, :stripe_customer_id] ++ coherence_fields())
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end

  def changeset(model, params, :password) do
    model
    |> cast(params, ~w(password password_confirmation reset_password_token reset_password_sent_at))
    |> validate_coherence_password_reset(params)
  end

  def find_or_create_with_credentials(name, email, provider, token, token_secret) do
    # create/update user in db
    user = case Repo.get_by(User, email: email) do
      nil ->
        Logger.info "User: could not find user with email #{email}"
        %User{}
        |> User.changeset(%{name: name,
                            email: email,
                            password: token,
                            password_confirmation: token})
        |> Repo.insert!
      user ->
        Logger.info "User: found user with email #{email}"
        user
        |> User.changeset(%{name: name})
        |> Repo.update!
    end

    credential = case Repo.get_by(UserCredential, provider: provider, user_id: user.id) do
      nil ->
        Logger.info "User: could not find credentials for user with #{provider}"
        %UserCredential{}
        |> UserCredential.changeset(%{user_id: user.id,
                                      provider: provider,
                                      token: token,
                                      secret: token_secret})
        |> Repo.insert!
      credential ->
        Logger.info "User: found credentials for user with #{provider}"
        credential
        |> UserCredential.changeset(%{token: token, token_secret: token_secret})
        |> Repo.update!
    end

    user
  end

  def get_stripe_customer_id(nil), do: nil
  def get_stripe_customer_id(%{id: user_id} = user) do
    from(
      u in User,
      where: u.id == ^user_id,
      select: u.stripe_customer_id
    )
    |> Repo.one!
  end

  def update_stripe_customer_id(user, stripe_customer_id) do
    user
    |> User.changeset(%{
      stripe_customer_id: stripe_customer_id
    })
    |> Repo.update!
    |> IO.inspect
  end
end
