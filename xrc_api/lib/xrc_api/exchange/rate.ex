defmodule XrcApi.Exchange.Rate do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "rates" do
    field :base, :string
    field :currency, :string
    field :rate, :float
    field :date_rate, :string
    field :base_currency, :string

    timestamps()
  end

  @doc false
  def changeset(rate, attrs) do
    rate
    |> cast(attrs, [:base, :currency, :rate, :date_rate, :base_currency])
    |> validate_required([:base, :currency, :rate, :date_rate, :base_currency])
    |> unique_constraint(:base_currency)
  end
end
