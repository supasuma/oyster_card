class Oystercard

  attr_reader :balance
  attr_accessor :in_journey
  alias :in_journey? :in_journey

  BALANCE_LIMIT = 90


  def initialize
    @balance = 0
    @in_journey = false
  end

  # def in_journey?
  #   @in_journey
  # end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def top_up(value)
    fail "Your top up will exceed balance limit of #{BALANCE_LIMIT}!" if value + balance > BALANCE_LIMIT
    @balance += value
  end

  def deduct(fare)
    @balance -= fare
  end



end
