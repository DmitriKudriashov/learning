# bank.rb
class Bank
  include Validation

  validate :balance, :negative

  attr_reader :balance

  def initialize(sum)
    @balance = sum
    validate!
  end

  def pay(money)
    @balance -= money
  end

  def get(money)
    @balance += money
  end
end

