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

  describe 'order_num' do
    let(:order) { create(:order) }
    let(:user) { order.user }
    let(:user2) { create(:user) }

    it 'should be 1 for the first order from a user' do
      expect(order.order_num).to eq(1)
    end

    it 'should auto increment for another order from the same user' do
      order2 = create(:order, user: user)
      expect(order2.order_num).to eq(2)
    end

    it 'should start at 1 for another user' do
      order3 = create(:order, user: user2)
      expect(order3.order_num).to eq(1)
    end

    describe 'manually adding an order number' do
      let!(:order999) { create(:order, user: user, order_num: 999) }

      it 'should have the desired order number' do
        expect(order999.order_num).to eq(999)
      end

      it 'should auto increment for the next order' do
        expect(create(:order, user: user).order_num).to eq(1000)
      end
    end

    it 'should allow forcing an order_num' do
      order999 = create(:order, user: user, order_num: 999)
      expect(order999.order_num).to eq(999)
    end

    it 'should allow forcing an order_num' do
      order999 = create(:order, user: user, order_num: 999)
      expect(order999.order_num).to eq(999)
    end
  end

  describe 'tabulation' do
    include_context 'four users with thirteen orders'

    it 'count_orders_by_week returns right number of weeks' do
      expect(Order.count_orders_by_week).to have(4).items
    end

    it 'count_orders_by_week should return the right data' do
      expect(Order.count_orders_by_week).to eq([{ orderers: 2, first_orders: 2 },
                                                { orderers: 2, first_orders: 1 },
                                                { orderers: 3, first_orders: 1 },
                                                { orderers: 1, first_orders: 0 }])
    end

    it 'count_orders_by_week limits weeks' do
      expect(Order.count_orders_by_week(2)).to have(2).items
    end
  end
end
