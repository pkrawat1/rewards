# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rewards.Repo.insert!(%Rewards.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Rewards.Seeds do
  alias Rewards.Seeds.{Setting}

  def run() do
    Setting.seed!()
  end
end

Rewards.Seeds.run()
