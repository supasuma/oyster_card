class Oystercard

  attr_reader :balance
  attr_accessor :in_journey
  alias :in_journey? :in_journey

  BALANCE_LIMIT = 90
  MIN_FARE = 1



  def initialize
    @balance = 0
    @in_journey = false
  end

  # def in_journey?
  #   @in_journey
  # end

  def touch_in
    fail 'you have insufficient funds on your oystercard' if balance < MIN_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MIN_FARE)
  end

  def top_up(value)
    fail "Your top up will exceed balance limit of #{BALANCE_LIMIT}!" if value + balance > BALANCE_LIMIT
    @balance += value
  end

private

  def deduct(fare)
    @balance -= fare
  end



end
