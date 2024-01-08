defmodule RewardsWeb.SettingController do
  use RewardsWeb, :controller
  use PhoenixSwagger

  alias Rewards.Core
  alias Rewards.Core.Setting

  action_fallback RewardsWeb.FallbackController

  def swagger_definitions do
    %{
      Setting:
        swagger_schema do
          properties do
            currency(:string, "Currency code")
            reward_percentage(:string, "reward percent config")
          end

          example(%{
            currency: "JPY",
            reward_percentage: "1"
          })
        end
    }
  end

  swagger_path :show do
    get("/settings")
    summary("Get global setting")

    description("Shows the setting information")

    tag("Setting")

    operation_id("show_setting")

    response(
      200,
      "OK",
      swagger_schema do
        properties do
          data(Schema.ref(:Setting))
        end
      end
    )

    response(
      404,
      "Not found",
      swagger_schema do
        properties do
          data(Schema.ref(:Error))
        end
      end
    )
  end

  def show(conn, _) do
    setting = Core.get_setting!()
    render(conn, :show, setting: setting)
  end

  swagger_path :update do
    patch("/settings")
    summary("update global setting")

    description("Updates the setting information")

    tag("Setting")

    operation_id("update_setting")

    parameters do
      body(
        :body,
        swagger_schema do
          properties do
            setting(Schema.ref(:Setting))
          end
        end,
        "Setting parameters"
      )
    end

    response(
      200,
      "OK",
      swagger_schema do
        properties do
          data(Schema.ref(:Setting))
        end
      end
    )

    response(
      404,
      "Not found",
      swagger_schema do
        properties do
          data(Schema.ref(:Error))
        end
      end
    )
  end

  def update(conn, %{"setting" => setting_params}) do
    setting = Core.get_setting!()

    with {:ok, %Setting{} = setting} <- Core.update_setting(setting, setting_params) do
      render(conn, :show, setting: setting)
    end
  end
end
