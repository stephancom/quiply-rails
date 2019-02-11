require 'rails_helper'

RSpec.describe CohortsHelper, type: :helper do
  describe '#relative_week' do
    it 'works for week 0' do
      expect(helper.relative_week(0)).to eq('0-7 days')
    end
    it 'works for week 1' do
      expect(helper.relative_week(1)).to eq('7-14 days')
    end
    it 'works for week 2' do
      expect(helper.relative_week(2)).to eq('14-21 days')
    end
    it 'works for week 3' do
      expect(helper.relative_week(3)).to eq('21-28 days')
    end
  end
end
