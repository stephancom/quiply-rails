require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'building' do
    let!(:order) { create(:order) }
    let(:old_order_id) { order.old_id }
    let(:order_num) { order.order_nim }
    let(:user) { order.user }
    let(:old_user_id) { user.old_id }

    subject { order }

    it { is_expected.to be_valid, subject.errors.map { |k, v| "#{k} #{v}" }.join(', ') }
    it { is_expected.to respond_to(:old_id) }
    it { is_expected.to respond_to(:user) }
    it { is_expected.to respond_to(:order_num) }
    it { is_expected.to respond_to(:created_at) }
    it { is_expected.to respond_to(:updated_at) }

    it 'should belong to the expected user' do
      expect(order.user).to eq(user)
    end

    it 'should reference the user by the old id' do
      expect(order.user_id).to eq(user.old_id)
    end
  end
end
