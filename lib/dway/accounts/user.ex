defmodule Dway.Accounts.User do
  @moduledoc """
    user schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :email, :string

    timestamps()
  end

  @doc """
    validating user e-mail(unique)

    email must have an '@' and don't have any white spaces
    min length: 3
    max length: 160
  """
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:email])
    |> validate_required(:email)
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/,
      message: "E-mail deve possuir @ e não conter espaços"
    )
    |> validate_length(:email,
      max: 160,
      message: "O tamanho máximo é de 160 caracteres"
    )
    |> unique_constraint(:email)
  end
end
