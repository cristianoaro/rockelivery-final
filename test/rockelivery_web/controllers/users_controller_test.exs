defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.ViaCep.ClientMock
  alias RockeliveryWeb.Auth.Guardian

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = %{
        "age" => 19,
        "address" => "Rua dos testes, 1234",
        "cep" => "01001000",
        "cpf" => "12345678900",
        "email" => "teste@teste.com",
        "password" => "123456",
        "name" => "Teste 01"
      }

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response =
        conn
        |> post(Routes.user_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created",
               "user" => %{
                 "address" => "Rua dos testes, 1234",
                 "age" => 19,
                 "cpf" => "12345678900",
                 "email" => "teste@teste.com",
                 "id" => _id
               }
             } = response
    end

    test "when there is some error, returns the error - age less than 18", %{conn: conn} do
      params = %{
        age: 15,
        address: "Rua dos testes, 1234",
        cep: "01001000",
        cpf: "12345678900",
        email: "teste@teste.com",
        password: "123456",
        name: "Teste 01"
      }

      response =
        conn
        |> post(Routes.user_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"message" => %{"age" => ["must be greater than or equal to 18"]}} = response
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      id = "5b1addd2-0493-4cfd-9d61-cf662594e685"

      response =
        conn
        |> delete(Routes.user_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end

    test "when there is not a user with the given id, return an error 404", %{conn: conn} do
      id = "5b1addd2-0493-4cfd-9d61-cf662594e684"

      response =
        conn
        |> delete(Routes.user_path(conn, :delete, id))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found"}

      assert response == expected_response
    end
  end
end
