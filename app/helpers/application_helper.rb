# Helpers available across the site
module ApplicationHelper
  # format a span of time
  #
  # @param span [Range] range of Time objects
  # @return [String] range expressed as a mm/dd-mm/dd string eg 8/26-9/2
  def timespan_format(span)
    [span.first, span.last].map { |t| t.strftime('%-m/%-d') }.join('-')
  end

  def to_percent(count, total, digits = 0)
    # "#{((count * 100) / total).round(digits)}%"
    number_to_percentage((count * 100) / total, precision: digits)
  end
end
