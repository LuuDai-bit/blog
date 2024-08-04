module RemindsHelper
  DAYS_OF_WEEK = %w[Mon Tue Wed Thu Fri Sat Sun]

  def day_format(day)
    day.join(', ')
  end

  def selected_day(day)
    return Settings.models.reminder.day.to_h.keys.first if day.blank?

    selected_keys = []
    Settings.models.reminder.day.to_h.each do |key, value|
      return key if value.to_s == day.to_s

      selected_keys << key if day.include?(value)
    end

    return selected_keys if selected_keys.present?
  end

  private

  def two_character_number_format(number)
    number = number.to_i
    number < 10 ? "0#{number}" : number
  end
end
