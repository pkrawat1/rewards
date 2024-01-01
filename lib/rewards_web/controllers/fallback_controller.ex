defmodule RewardsWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use RewardsWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: RewardsWeb.ErrorHTML, json: RewardsWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, %{errors: errors}}) do
    conn
    |> put_status(422)
    |> json(%{error: Enum.map(errors, &format_error/1)})
  end

  defp format_error({field, message}) do
    %{field: field, message: elem(message, 0)}
  end
end
