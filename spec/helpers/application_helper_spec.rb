require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#timespan' do
    let(:start) { Time.zone.parse('2014-10-31 17:01:00 -0500') }
    let(:finish) { Time.zone.parse('2015-01-02 10:20:00 -0500') }
    let(:span) { start..finish }
    let(:start_in_la) { Time.zone.parse('2014-10-31 17:01:00 -0800') }
    let(:span_la_ny) { start_in_la..finish }

    it 'should format properly' do
      expect(helper.timespan_format(span)).to eq('10/31-1/2')
    end

    it 'should account for time zones' do
      expect(helper.timespan_format(span_la_ny)).to eq('11/1-1/2')
    end
  end

  describe '#percentage' do
    it { expect(helper.to_percent(1, 2)).to eq('50%') }
    it { expect(helper.to_percent(25, 100)).to eq('25%') }
    it { expect(helper.to_percent(22, 7)).to eq('314%') }
    it { expect(helper.to_percent(-7, 22)).to eq('-32%') }
    it { expect(helper.to_percent(99.44, 100, 2)).to eq('99.44%') }
    it { expect(helper.to_percent(22.0, 7.0)).to eq('314%') }
    it { expect(helper.to_percent(355.0, 113.0, 1)).to eq('314.2%') }
    it { expect(helper.to_percent(355.0, 113.0, 3)).to eq('314.159%') }
  end
end
