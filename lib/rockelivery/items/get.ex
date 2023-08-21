defmodule Rockelivery.Items.Get do
  alias Rockelivery.Error
  alias Rockelivery.Item
  alias Rockelivery.Repo

  def by_id(id) do
    case Repo.get(Item, id) do
      nil -> Error.build(:not_found, "Item not found")
      item -> {:ok, item}
    end
  end
end
