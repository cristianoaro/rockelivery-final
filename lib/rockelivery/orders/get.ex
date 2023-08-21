defmodule Rockelivery.Orders.Get do
  alias Rockelivery.Error
  alias Rockelivery.Order
  alias Rockelivery.Repo

  def by_id(id) do
    case Repo.get(Order, id) do
      nil -> Error.build(:not_found, "Order not found")
      order -> {:ok, Repo.preload(order, [:items])}
    end
  end
end
