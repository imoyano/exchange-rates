defmodule XrcApi.Repo.Migrations.CreateRates do
  use Ecto.Migration

  def change do
    create table(:rates, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :base, :string
      add :currency, :string
      add :rate, :float
      add :date_rate, :string

      timestamps()
    end

  end
end
