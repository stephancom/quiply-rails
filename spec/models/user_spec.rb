require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creation' do
    let!(:user) { create(:user) }
    let(:old_user_id) { user.old_id }

    subject { user }

    it { is_expected.to be_valid, subject.errors.map { |k, v| "#{k} #{v}" }.join(', ') }
    it { is_expected.to respond_to(:old_id) }
    it { is_expected.to respond_to(:orders) }
    it { is_expected.to respond_to(:created_at) }
    it { is_expected.to respond_to(:updated_at) }

    describe 'without orders' do
      it 'should have no orders' do
        expect(user.orders.reload).to be_empty
      end
    end

    describe 'with one order' do
      let!(:order) { create(:order, user: user) }
      let(:old_order_id) { order.old_id }
      let(:order_num) { order.order_num }

      it 'should have one order' do
        expect(user.orders).to have(1).item
      end

      it 'should include the specified' do
        expect(user.orders).to include(order)
      end
    end
  end
end
