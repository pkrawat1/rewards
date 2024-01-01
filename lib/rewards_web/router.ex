defmodule RewardsWeb.Router do
  use RewardsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RewardsWeb do
    pipe_through :api

    get "/settings", SettingController, :show
    patch "/settings", SettingController, :update

    resources "/customers", CustomerController, except: [:new, :edit]
  end
end
