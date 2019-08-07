defmodule HighNoonWeb.Router do
  use HighNoonWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", HighNoonWeb do
    pipe_through :api
  end
end
