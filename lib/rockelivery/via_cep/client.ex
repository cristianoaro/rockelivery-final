defmodule Rockelivery.ViaCep.Client do
  use Tesla

  alias Rockelivery.Error
  alias Rockelivery.ViaCep.Behavior
  alias Tesla.Env

  @behaviour Behavior

  @base_url "https://viacep.com.br/ws"

  plug Tesla.Middleware.JSON

  def get_cep_info(url \\ @base_url, cep) do
    "#{url}/#{cep}/json/"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: %{"erro" => true}}}) do
    Error.build(:not_found, "CEP not found!")
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Env{status: 400, body: _body}}) do
    Error.build(:bad_request, "Invalid CEP!")
  end

  defp handle_get({:error, reason}) do
    Error.build(:bad_request, reason)
  end
end
