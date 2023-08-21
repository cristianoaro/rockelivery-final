defmodule Rockelivery.Orders.Delete do
  alias Rockelivery.Error
  alias Rockelivery.Order
  alias Rockelivery.Repo

  def call(id) do
    case Repo.get(Order, id) do
      nil -> Error.build(:not_found, "Order not found")
      order -> Repo.delete(order)
    end
  end
end
