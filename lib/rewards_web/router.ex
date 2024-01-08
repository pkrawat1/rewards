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

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :rewards,
      swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      schemes: ["http", "https", "ws", "wss"],
      basePath: "/api",
      info: %{
        version: "1.0",
        title: "Rewards"
      },
      consumes: ["application/json"],
      produces: ["application/json"],
      tags: [
        %{name: "Setting", description: "Setting resources"},
        %{name: "Customer", description: "Customer resources"},
        %{name: "Order", description: "Order resources"}
      ]
    }
  end
end
