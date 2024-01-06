defmodule RewardsWeb.Router do
  use RewardsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RewardsWeb do
    pipe_through :api

    get "/settings", SettingController, :show
    patch "/settings", SettingController, :update

    get "/customers/:identifier/balance", CustomerController, :balance
    post "/customers/:identifier/balance", CustomerController, :update_balance

    resources "/orders", OrderController, only: [:create, :show]
  end
end
