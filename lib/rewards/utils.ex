defmodule Rewards.Utils do
  @moduledoc """
  The Utils context.
  """

  def sanitize_phone_number(phone_number) when is_integer(phone_number), do: "#{phone_number}"

  def sanitize_phone_number(phone_number) when is_bitstring(phone_number),
    do: String.replace(phone_number, ~r/\+|\(|\)|\s|-/, "")

  def sanitize_phone_number(_), do: ""

  def email_regexp(), do: ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/
end
