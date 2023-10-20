defmodule XrcApi.Repo.Migrations.AddUniqueCurrencyIndex do
  use Ecto.Migration

  def change do
    alter table(:rates) do
      add :base_currency, :string
    end

    create unique_index(:rates, :base_currency)
  end
end
