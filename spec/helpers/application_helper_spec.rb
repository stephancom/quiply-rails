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
end
