defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.Changeset
  alias Rockelivery.User

  import Rockelivery.Factory

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Teste 01", cpf: "12345678900"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:user_params)

      changeset = User.changeset(params)

      update_params = %{name: "Teste 02", password: "123456"}

      response = User.changeset(changeset, update_params)

      assert %Changeset{changes: %{name: "Teste 02", cpf: "12345678900"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset - miss param [age field blank] (validation_required)" do
      params = :user_params |> build() |> Map.delete("age")

      response = User.changeset(params)

      expected_response = %{age: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end

    test "when there are some error, returns an invalid changeset - age less 18, cpf length less 11, cep length less 8, password length less 6, email format contains '@'" do
      params =
        build(
          :user_params,
          %{
            "age" => 15,
            "cep" => "0100100",
            "cpf" => "1234567890",
            "email" => "teste_teste.com",
            "password" => "12345"
          }
        )

      response = User.changeset(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        cep: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        email: ["has invalid format"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
