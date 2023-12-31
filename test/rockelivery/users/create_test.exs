defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  alias Rockelivery.Error
  alias Rockelivery.User
  alias Rockelivery.Users.Create
  alias Rockelivery.ViaCep.ClientMock

  import Mox
  import Rockelivery.Factory

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response = Create.call(params)

      assert {:ok, %User{id: _id, cpf: "12345678900", email: "teste@teste.com"}} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:user_params, %{"age" => 15})

      response = Create.call(params)
      {:error, %Error{status: status, result: changeset}} = response

      expected_response = %{age: ["must be greater than or equal to 18"]}

      assert :bad_request == status
      assert errors_on(changeset) == expected_response
    end
  end
end
