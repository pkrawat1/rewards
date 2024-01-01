defmodule Rewards.CoreTest do
  use Rewards.DataCase

  alias Rewards.Core

  describe "settings" do
    alias Rewards.Core.Setting

    import Rewards.CoreFixtures

    @invalid_attrs %{currency: nil, reward_percentage: nil}

    test "list_settings/0 returns all settings" do
      setting = setting_fixture()
      assert Core.list_settings() == [setting]
    end

    test "get_setting!/1 returns the setting with given id" do
      setting = setting_fixture()
      assert Core.get_setting!(setting.id) == setting
    end

    test "create_setting/1 with valid data creates a setting" do
      valid_attrs = %{currency: "JPY", reward_percentage: "99.99"}

      assert {:ok, %Setting{} = setting} = Core.create_setting(valid_attrs)
      assert setting.currency == "JPY"
      assert setting.reward_percentage == Decimal.new("99.99")
    end

    test "create_setting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_setting(@invalid_attrs)
    end

    test "update_setting/2 with valid data updates the setting" do
      setting = setting_fixture()
      update_attrs = %{currency: "JPY", reward_percentage: "99.99"}

      assert {:ok, %Setting{} = setting} = Core.update_setting(setting, update_attrs)
      assert setting.currency == "JPY"
      assert setting.reward_percentage == Decimal.new("99.99")
    end

    test "update_setting/2 with invalid data returns error changeset" do
      setting = setting_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_setting(setting, @invalid_attrs)
      assert setting == Core.get_setting!(setting.id)
    end

    test "delete_setting/1 deletes the setting" do
      setting = setting_fixture()
      assert {:ok, %Setting{}} = Core.delete_setting(setting)
      assert_raise Ecto.NoResultsError, fn -> Core.get_setting!(setting.id) end
    end

    test "change_setting/1 returns a setting changeset" do
      setting = setting_fixture()
      assert %Ecto.Changeset{} = Core.change_setting(setting)
    end
  end
end
