defmodule RewardsWeb.CustomerJSON do
  @doc """
  Renders customer balance
  """
  alias Rewards.Account.Customer
  alias Rewards.Reward.PointsHistory

  def balance(%{latest_points_history: latest_points_history, customer: customer}) do
    %{
      data: %{
        customer: data(customer),
        balance:
          data(latest_points_history) ||
            %{
              balance: nil,
              last_transaction_points: nil,
              last_transaction_type: nil
            }
      }
    }
  end

  defp data(%Customer{} = customer) do
    %{
      id: customer.id,
      email: customer.email,
      phone: customer.phone
    }
  end

  defp data(%PointsHistory{balance: balance, transaction_type: transaction_type, points: points}) do
    %{
      balance: balance,
      last_transaction_points: points,
      last_transaction_type: transaction_type
    }
  end

  defp data(_), do: nil
end
