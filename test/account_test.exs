defmodule AccountTest do
  use ExUnit.Case

  describe "Check initial account" do
    test "Initial account is zero" do
      {:ok, pid} = Account.start_link(0)

      assert 0 == Account.get_balance(pid)
    end
  end

  describe "Adds money to account" do
    test "Adding money updates balance" do
      {:ok, pid} = Account.start_link(100)

      Account.deposit(pid, 10.0)

      assert 110.0 == Account.get_balance(pid)
    end
  end

  describe "Removes money to account" do
    test "Withdrawing amount reduces balance" do
      {:ok, pid} = Account.start_link(1000)

      Account.withdraw(pid, 52.34)

      assert 947.66 == Account.get_balance(pid)
    end
  end

end
