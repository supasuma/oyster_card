class Oystercard

  attr_reader :balance
  BALANCE_LIMIT = 90


  def initialize
    @balance = 0
  end


  def top_up(value)
    fail "Your top up will exceed balance limit of #{BALANCE_LIMIT}!" if value + balance > BALANCE_LIMIT
    @balance += value
  end

  def deduct(fare)
    @balance -= fare
  end

end
