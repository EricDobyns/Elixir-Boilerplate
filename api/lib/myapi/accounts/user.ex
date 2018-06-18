defmodule MyApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name_first, :string
    field :name_middle, :string
    field :name_last, :string
    field :address_lineOne, :string
    field :address_lineTwo, :string
    field :address_city, :string
    field :address_state, :string
    field :address_postcode, :string
    field :address_province, :string
    field :address_country, :string
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :phone, :string
    field :dob, :date
    field :photoUrl, :string
    field :is_banned, :boolean, default: false, null: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name_first, :name_middle, :name_last, :address_lineOne, :address_lineTwo, :address_city, :address_state, :address_postcode, :address_province, :address_country, :username, :email, :password, :phone, :dob, :photoUrl, :is_banned])
    |> validate_required([:name_first, :name_last])
    |> validate_length(:username, min: 1, max: 20)
    |> update_change(:username, &String.downcase/1)
    |> validate_required_inclusion([:email, :phone])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase/1)
    |> validate_confirmation(:password, message: "Passwords does not match", required: true)
    |> unique_constraint(:username, message: "Username already exists")
    |> unique_constraint(:email, message: "Email already exists")
    |> unique_constraint(:phone, message: "Phone number already exists")
    |> put_password_hash()
  end

  # Validate that at least one field is included
  def validate_required_inclusion(changeset, fields) do
    if Enum.any?(fields, &present?(changeset, &1)) do
      changeset
    else
      # Add the error to the first field only since Ecto requires a field name for each error.
      add_error(changeset, hd(fields), "One of these fields must be present: #{inspect fields}")
    end
  end

  def present?(changeset, field) do
    value = get_field(changeset, field)
    value && value != ""
  end

  # Password Validation
  defmodule PasswordValidator do

    @valid_upper 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    @valid_lower 'abcdefghijklmnopqrstuvwxyz'
    @valid_num '0123456789'

    def validate(pass) do
      chars =
        pass
        |> String.to_charlist()

      valid_length?(chars) and has_valid_chars?(chars) and has_required_chars?(chars)
    end

    defp valid_length?(chars) when is_list(chars) do
      length(chars) >= 6 and length(chars) <= 32
    end

    defp has_valid_chars?(chars) when is_list(chars) do
      Enum.all?(chars, &validate_char/1)
    end

    defp has_required_chars?(chars) when is_list(chars) do
      [&has_upper/1, &has_lower/1, &has_num/1]
      |> Enum.all?(&Enum.any?(chars, &1))
    end

    defp validate_char(char) do
      has_upper(char) or has_lower(char) or has_num(char)
    end

    defp has_upper(char) do
      char in @valid_upper
    end

    defp has_lower(char) do
      char in @valid_lower
    end

    defp has_num(char) do
      char in @valid_num
    end
  end

  # Hash Password
  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash,   
                  Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset  
    end
  end
end
