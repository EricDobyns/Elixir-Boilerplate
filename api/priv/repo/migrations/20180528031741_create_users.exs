defmodule MyApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name_first, :string
      add :name_middle, :string
      add :name_last, :string
      add :address_lineOne, :string
      add :address_lineTwo, :string
      add :address_city, :string
      add :address_state, :string
      add :address_postcode, :string
      add :address_province, :string
      add :address_country, :string
      add :username, :string
      add :email, :string
      add :password_hash, :string
      add :phone, :string
      add :dob, :date
      add :photoUrl, :string
      add :is_banned, :boolean

      timestamps()
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
    create unique_index(:users, [:phone])
  end
end
