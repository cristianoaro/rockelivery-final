defmodule Rockelivery.Items.Delete do
  alias Rockelivery.Error
  alias Rockelivery.Item
  alias Rockelivery.Repo

  def call(id) do
    case Repo.get(Item, id) do
      nil -> Error.build(:not_found, "Item not found")
      item -> Repo.delete(item)
    end
  end
end
