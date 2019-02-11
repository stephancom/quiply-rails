# helpers for rendering cohort matrix
module CohortsHelper
  # render a hash of orders/first time orderers per week
  #
  # @param users_count [Integer] number of users - used in calculations
  # @param weeks_count [Integer] how many weeks to include in columns.  Default: 8
  # @return [Array] an array of strings, one per week.
  def cohort_orders_per_week(order_scope, users_count, weeks_count = 8)
    order_scope.count_orders_by_week(weeks_count).map do |w|
      # TODO: I18n
      <<~EOWEEK
        #{number_to_percentage(w[:orderers] * 100 / users_count, precision: 0)} orderers (#{w[:orderers]})
        #{number_to_percentage(w[:first_orders] * 100 / users_count, precision: 0)} 1st Time (#{w[:first_orders]})
      EOWEEK
    end
  end
end
