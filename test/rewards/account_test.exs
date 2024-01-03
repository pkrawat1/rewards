defmodule Rewards.AccountTest do
  use Rewards.DataCase

  alias Rewards.Account

  describe "customers" do
    alias Rewards.Account.Customer

    import Rewards.AccountFixtures

    @invalid_attrs %{email: nil, phone: nil}

    test "get_customer_by_identifier!/1 returns the customer with given identifier" do
      customer = customer_fixture()
      assert Account.get_customer_by_identifier!(customer.email) == customer
      assert Account.get_customer_by_identifier!(customer.phone) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{email: "some email", phone: "some phone"}

      assert {:ok, %Customer{} = customer} = Account.create_customer(valid_attrs)
      assert customer.email == "some email"
      assert customer.phone == "some phone"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      update_attrs = %{email: "some updated email", phone: "some updated phone"}

      assert {:ok, %Customer{} = customer} = Account.update_customer(customer, update_attrs)
      assert customer.email == "some updated email"
      assert customer.phone == "some updated phone"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_customer(customer, @invalid_attrs)
      assert customer == Account.get_customer_by_identifier!(customer.email)
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Account.change_customer(customer)
    end
  end
end
