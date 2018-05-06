defmodule TicketAgent.User do
  @moduledoc false
  use TicketAgent.Schema
  use Coherence.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  @foreign_key_type :binary_id

  schema "users" do
    belongs_to :account, Account
    has_many :orders, Order
    field :name, :string
    field :email, :string
    coherence_schema()
    field :role, :string
    field :stripe_customer_id, :string
    field :one_time_token, :string
    field :one_time_token_at, :utc_datetime
    timestamps(type: :utc_datetime)
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :email, :account_id, :role, :stripe_customer_id, :one_time_token, :one_time_token_at] ++ coherence_fields())
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end

  def changeset(model, params, :stripe_customer_id) do
    model
    |> cast(params, ~w(stripe_customer_id))
  end

  def changeset(model, params, :password) do
    model
    |> cast(params, ~w(password password_confirmation reset_password_token reset_password_sent_at))
    |> validate_coherence_password_reset(params)
  end

  def list_users(params) do
    User
    |> order_by([:role, :name, :email])
    |> Repo.paginate(params)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs, originator) do
    user
    |> User.changeset(attrs)
    |> PaperTrail.update(originator: originator)
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def find_or_create_with_credentials(name, email, provider, token, token_secret, extra_details \\ %{}) do
    # create/update user in db
    user = case Repo.get_by(User, email: email) do
      nil ->
        Logger.info "User: could not find user with email #{email}"

        user =
          %User{}
          |> User.changeset(%{name: name,
                              email: email,
                              password: token,
                              password_confirmation: token,
                              role: "oauth_customer"})
          |> Repo.insert!
          Task.start(fn ->
            send_welcome_email(name, email)
          end)
          user
      user ->
        Logger.info "User: found user with email #{email}"
        user
        |> User.changeset(%{name: name})
        |> Repo.update!
    end

    case Repo.get_by(UserCredential, provider: provider, user_id: user.id) do
      nil ->
        Logger.info "User: could not find credentials for user with #{provider}"
        %UserCredential{}
        |> UserCredential.changeset(%{user_id: user.id,
                                      provider: provider,
                                      token: token,
                                      secret: token_secret,
                                      extra_details: extra_details})
        |> Repo.insert!
      credential ->
        Logger.info "User: found credentials for user with #{provider}"
        credential
        |> UserCredential.changeset(%{token: token, secret: token_secret, extra_details: extra_details})
        |> Repo.update!
    end
    user
  end

  def send_welcome_email(name, email) do
    TicketAgent.Emails.UserWelcomeEmail.welcome_email(name, email)
    |> TicketAgent.Mailer.deliver!
  end

  def get_stripe_customer_id(nil), do: nil
  def get_stripe_customer_id(%{id: user_id}) do
    from(
      u in User,
      where: u.id == ^user_id,
      select: u.stripe_customer_id
    )
    |> Repo.one!
  end

  def update_stripe_customer_id(user, stripe_customer_id) do
    changeset =
      user
      |> User.changeset(%{stripe_customer_id: stripe_customer_id}, :stripe_customer_id)

    case Repo.update(changeset) do
      {:ok, user} ->
        {:ok, user}
      {:error, error} ->
        Logger.error "update_stripe_customer_id->There was an error updating this user #{inspect error}"
        {:error, :persistence_error}
    end
  end
end
