module ItemsHelper

  WEEK_DAYS = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"] 
  WEEKEND_DAYS = ["Saturday", "Sunday"]
  CURRENT_DAY_OF_WEEK =  DateTime.now.strftime("%A")
  T = DateTime.now
  CURRENT_DATE= T.day
  CURRENT_YEAR = T.year
  CURRENT_MONTH = T.month

  def breakfast_time?
    start_time = Time.new(CURRENT_YEAR, CURRENT_MONTH, CURRENT_DATE, 06, 00, 59).in_time_zone('Eastern Time (US & Canada)')
    end_time = Time.new(CURRENT_YEAR, CURRENT_MONTH, CURRENT_DATE, 10, 59, 59).in_time_zone('Eastern Time (US & Canada)')
    DateTime.now.between?(start_time, end_time) && WEEK_DAYS.include?(CURRENT_DAY_OF_WEEK)
  end

  def lunch_time?
    start_time = Time.new(CURRENT_YEAR, CURRENT_MONTH, CURRENT_DATE, 11, 00, 59).in_time_zone('Eastern Time (US & Canada)')
    end_time = Time.new(CURRENT_YEAR, CURRENT_MONTH, CURRENT_DATE, 15, 59, 59).in_time_zone('Eastern Time (US & Canada)')
    DateTime.now.between?(start_time, end_time) && WEEK_DAYS.include?(CURRENT_DAY_OF_WEEK)
  end

  def happy_hour_time?
    start_time = Time.new(CURRENT_YEAR, CURRENT_MONTH, CURRENT_DATE, 15, 59, 59).in_time_zone('Eastern Time (US & Canada)')
    end_time = Time.new(CURRENT_YEAR, CURRENT_MONTH, CURRENT_DATE, 18, 59, 59).in_time_zone('Eastern Time (US & Canada)')
    DateTime.now.between?(start_time, end_time) && WEEK_DAYS.include?(CURRENT_DAY_OF_WEEK)  
  end

  def dinner_time?
    start_time = Time.new(CURRENT_YEAR, CURRENT_MONTH, CURRENT_DATE, 00, 00, 00).in_time_zone('Eastern Time (US & Canada)')
    end_time = Time.new(CURRENT_YEAR, CURRENT_MONTH, CURRENT_DATE, 21, 59, 59).in_time_zone('Eastern Time (US & Canada)')
    DateTime.now.between?(start_time, end_time)  
  end

  def late_night_time?
    start_time = Time.new(CURRENT_YEAR, CURRENT_MONTH, CURRENT_DATE, 21, 00, 00).in_time_zone('Eastern Time (US & Canada)')
    end_time = Time.new(CURRENT_YEAR, CURRENT_MONTH, CURRENT_DATE, 23, 59, 59).in_time_zone('Eastern Time (US & Canada)')
    DateTime.now.between?(start_time, end_time)
  end

  def brunch_time?
    start_time = Time.new(CURRENT_YEAR, CURRENT_MONTH, CURRENT_DATE, 9, 00, 00).in_time_zone('Eastern Time (US & Canada)')
    end_time = Time.new(CURRENT_YEAR, CURRENT_MONTH, CURRENT_DATE, 15, 59, 00).in_time_zone('Eastern Time (US & Canada)')
    DateTime.now.between?(start_time, end_time) && WEEKEND_DAYS.include?(CURRENT_DAY_OF_WEEK)
  end
end
