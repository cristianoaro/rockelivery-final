defmodule Rockelivery.Users.Get do
  alias Rockelivery.Error
  alias Rockelivery.Repo
  alias Rockelivery.User

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> Error.build_user_not_found_error()
      user -> {:ok, user}
    end
  end
end
