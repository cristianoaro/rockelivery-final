defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "age" => 27,
      "address" => "Rua dos testes, 1234",
      "cep" => "01001000",
      "cpf" => "12345678900",
      "email" => "teste@teste.com",
      "password" => "123456",
      "name" => "Teste 01"
    }
  end

  def user_factory do
    %User{
      age: 27,
      address: "Rua dos testes, 1234",
      cep: "01001000",
      cpf: "12345678900",
      email: "teste@teste.com",
      password_hash:
        "$pbkdf2-sha512$160000$.hT6ZwQcwH1.6acsV.Q4vQ$hZMVoNRIVkZNSJOqhV6NnB65V4Glv4J/p8iefVd1OdsYJ/e81q2tH.bvxZpxICbnBypBNo0Rvd8vZM2iVK5UzQ",
      name: "Teste 01",
      id: "5b1addd2-0493-4cfd-9d61-cf662594e685"
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
