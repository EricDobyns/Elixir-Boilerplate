defmodule MyApiWeb.UserView do
  use MyApiWeb, :view
  alias MyApiWeb.UserView
  require Logger

  def render("index.json", %{users: users}) do
    render_many(users, UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    Logger.info "USER: #{inspect user}"
    %{id: user.id,
    name_first: user.name_first,
    name_last: user.name_last,
    address_lineOne: user.address_lineOne,
    address_lineTwo: user.address_lineTwo,
    address_city: user.address_city,
    address_state: user.address_state,
    address_postcode: user.address_postcode,
    address_province: user.address_province,
    address_country: user.address_country,
    username: user.username,
    email: user.email,
    phone: user.phone,
    dob: user.dob,
    photoUrl: user.photoUrl}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{token: jwt}
  end
  
end
