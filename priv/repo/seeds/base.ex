defmodule Rewards.Seeds.Base do
  require Logger

  def log_error({:ok, _}, schema), do: Logger.info("#{schema} seeded successfully")

  def log_error({:error, changeset_errors}, schema) do
    Logger.error("#{schema} seed failed")

    Enum.each(changeset_errors.errors, fn {field, message} ->
      Logger.error("#{field} #{elem(message, 0)}")
    end)
  end
end
