defmodule Rewards.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rewards.Account` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        email: Faker.Internet.email(),
        phone: Faker.Phone.PtBr.phone()
      })
      |> Rewards.Account.create_customer()

    customer
  end
end
