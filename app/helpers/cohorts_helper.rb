# helpers for rendering cohort matrix
module CohortsHelper
  # render a hash of orders/first time orderers per week
  #
  # @param users_count [Integer] number of users - used in calculations
  # @param weeks_count [Integer] how many weeks to include in columns.  Default: 8
  # @return [Array] an array of strings, one per week.
  def cohort_orders_per_week(users_count, weeks_count = 8)
    Order.count_orders_by_week(weeks_count).map do |w|
      # TODO: I18n
      <<~EOWEEK
        #{to_percent(w[:orderers], users_count)} orderers (#{w[:orderers]})
        #{to_percent(w[:first_orders], users_count)} 1st Time (#{w[:first_orders]})
      EOWEEK
    end
  end
end
