# helpers for rendering cohort matrix
module CohortsHelper
  # return a string describing the day range of the given week number
  #
  # @param week [Integer] week number counting forward, starting with 0
  # @return [String] a description of the days range of the relative week eg "0-7 days", "7-14 days"
  def relative_week(week)
    "#{week * 7}-#{(week + 1) * 7} days"
  end
end
