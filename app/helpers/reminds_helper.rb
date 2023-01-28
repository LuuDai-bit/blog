module RemindsHelper
  def day_format(day)
    day.join(', ')
  end

  def time_format(hour, minute)
    "#{two_character_number_format(hour)}:#{two_character_number_format(minute)}"
  end

  private

  def two_character_number_format(number)
    number = number.to_i
    number < 10 ? "0#{number}" : number
  end
end
