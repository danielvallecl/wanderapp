module SessionsHelper

  def date_check
    event_date = 1
    event_time = 2
    date = Time.now
    return true
  end

  def sum(x, y)
    @mostra = 'Daniel Valle'
    @total_sum = x + y
    @total_sum *= 2
    return @mostra, @total_sum
  end

end
