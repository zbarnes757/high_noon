defmodule HighNoonWeb.Router do
  use HighNoonWeb, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug JSONAPI.EnsureSpec
  end

  scope "/api/v1", HighNoonWeb do
    pipe_through :api

    post "/accounts/signup", AccountController, :create
  end
end
