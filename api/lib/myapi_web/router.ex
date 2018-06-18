defmodule MyApiWeb.Router do
  use MyApiWeb, :router
  alias MyApi.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Guardian.AuthPipeline
  end

  scope "/api/v1", MyApiWeb do
    pipe_through :api
    post "/users", UserController, :create
    post "/users/login", UserController, :login
    post "/users/forgotPassword", UserController, :forgotPassword
    post "/users/resetPassword", UserController, :resetPassword
    post "/users/sendToken", UserController, :sendToken
    post "/users/validateToken", UserController, :validateToken    
  end

  scope "/api/v1", MyApiWeb do
    pipe_through [:api, :auth]
    get "/users", UserController, :index
    get "/users/me", UserController, :self
    get "/users/:id", UserController, :show
    patch "/users/:id", UserController, :update
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete
    post "/users/logout", UserController, :logout
  end  
end
