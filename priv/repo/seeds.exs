# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rockelivery.Repo.insert!(%Rockelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rockelivery.Item
alias Rockelivery.Order
alias Rockelivery.Repo
alias Rockelivery.User

user = %User{
  age: 28,
  address: "Rua dos testes",
  cep: "06727000",
  cpf: "12345678988",
  email: "testew@teste.com",
  password: "123456",
  name: "Teste 01"
}

%User{id: user_id} = Repo.insert!(user)

item1 = %Item{
  category: :food,
  description: "banana",
  price: Decimal.new("1.99"),
  photo: "priv/photos/banana.jpg"
}

item2 = %Item{
  category: :food,
  description: "banana frita",
  price: Decimal.new("4.99"),
  photo: "priv/photos/banana.jpg"
}

Repo.insert!(item1)
Repo.insert!(item2)

order = %Order{
  user_id: user_id,
  items: [
    item1,
    item2,
    item2
  ],
  address: "Rua dos Testadores, 1234, Testana",
  comments: "Teste 01 order",
  payment_method: :money
}

Repo.insert!(order)
