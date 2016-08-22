class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :in_journey

  def initialize
   @balance = 0
   @in_journey = false
  end

  def top_up(amount)
    fail "Can't add more than £#{MAXIMUM_BALANCE}" if balance + amount >  MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    in_journey
  end

  def touch_in
    fail "You're already touched in!" if in_journey
    fail "Your balance is less than £1" if below_limit?
    @in_journey = true
  end

  def touch_out
    fail "You're already touched out!" if !in_journey
    @in_journey = false
  end

  private
  def below_limit?
    balance < MINIMUM_BALANCE
  end

end
