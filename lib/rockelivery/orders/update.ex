defmodule Rockelivery.Orders.Update do
  alias Rockelivery.Error
  alias Rockelivery.Order
  alias Rockelivery.Repo

  def call(%{"id" => id} = params) do
    case Repo.get(Order, id) do
      nil -> Error.build(:not_found, "Order not found")
      order -> do_update(order, params)
    end
  end

  defp do_update(order, params) do
    order
    |> Order.changeset(params)
    |> Repo.update()
  end
end
