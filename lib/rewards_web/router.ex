defmodule RewardsWeb.Router do
  use RewardsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RewardsWeb do
    pipe_through :api
  end
end
