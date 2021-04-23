defmodule Account do
  use GenServer

  def init(amount) do
    {:ok, %{balance: amount}}
  end

  def start_link(amount) do
    GenServer.start_link(__MODULE__, amount)
  end

  @doc """
    Callbacks used in API's
  """
  def handle_call(:get_balance, _, state) do
    {:reply, Map.get(state, :balance), state}
  end

  def handle_cast({:deposit, amount}, state) do
    {:noreply, get_updated_balance(state, amount, &(&1 + &2))}
  end

  def handle_cast({:withdraw, amount}, state) do
    {:noreply, get_updated_balance(state, amount, &(&1 - &2))}
  end


  @doc """
    API calls to GenServer
  """
  def get_balance(pid) do
    GenServer.call(pid, :get_balance)
  end

  def deposit(pid, amount) do
    GenServer.cast(pid, {:deposit, amount})
  end

  def withdraw(pid, amount) do
    GenServer.cast(pid, {:withdraw, amount})
  end


  # Function to update balance based on amount and state
  defp get_updated_balance(state, amount, calculate_balance) do
    {_value, updated_balance} =
      Map.get_and_update(state, :balance, fn balance ->
        {balance, calculate_balance.(balance, amount)}
      end)

    updated_balance
  end
end
