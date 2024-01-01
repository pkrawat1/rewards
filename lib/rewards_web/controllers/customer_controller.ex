defmodule RewardsWeb.CustomerController do
  use RewardsWeb, :controller

  alias Rewards.Account
  alias Rewards.Account.Customer

  action_fallback RewardsWeb.FallbackController

  def index(conn, _params) do
    customers = Account.list_customers()
    render(conn, :index, customers: customers)
  end

  def create(conn, %{"customer" => customer_params}) do
    with {:ok, %Customer{} = customer} <- Account.create_customer(customer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/customers/#{customer}")
      |> render(:show, customer: customer)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Account.get_customer!(id)
    render(conn, :show, customer: customer)
  end

  def update(conn, %{"id" => id, "customer" => customer_params}) do
    customer = Account.get_customer!(id)

    with {:ok, %Customer{} = customer} <- Account.update_customer(customer, customer_params) do
      render(conn, :show, customer: customer)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Account.get_customer!(id)

    with {:ok, %Customer{}} <- Account.delete_customer(customer) do
      send_resp(conn, :no_content, "")
    end
  end
end
