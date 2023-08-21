defmodule Rockelivery.Items.Update do
  alias Rockelivery.Error
  alias Rockelivery.Item
  alias Rockelivery.Repo

  def call(%{"id" => id} = params) do
    case Repo.get(Item, id) do
      nil -> Error.build(:not_found, "Item not found")
      item -> do_update(item, params)
    end
  end

  defp do_update(item, params) do
    item
    |> Item.changeset(params)
    |> Repo.update()
  end
end
