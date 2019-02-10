require 'rails_helper'

RSpec.describe CohortsHelper, type: :helper do
  describe '#cohort_orders_per_week' do
    include_context 'four users with thirteen orders'

    it 'returns the right number of weeks' do
      expect(helper.cohort_orders_per_week(4)).to have(4).items
    end

    it 'returns the right data' do
      expect(helper.cohort_orders_per_week(4)).to eq(["50% orderers (2)\n50% 1st Time (2)\n",
                                                      "50% orderers (2)\n25% 1st Time (1)\n",
                                                      "75% orderers (3)\n25% 1st Time (1)\n",
                                                      "25% orderers (1)\n0% 1st Time (0)\n"])
    end

    it 'limits weeks' do
      expect(helper.cohort_orders_per_week(4, 2)).to have(2).items
    end

    it 'limits to the right data' do
      expect(helper.cohort_orders_per_week(4, 2)).to eq(["50% orderers (2)\n50% 1st Time (2)\n",
                                                         "50% orderers (2)\n25% 1st Time (1)\n"])
    end
  end
end
