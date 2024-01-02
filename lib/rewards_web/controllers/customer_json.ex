defmodule RewardsWeb.CustomerJSON do
  @doc """
  Renders customer balance
  """
  def balance(%{balance: balance}) do
    %{data: balance}
  end
end
