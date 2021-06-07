# frozen_string_literal: true

require './checkout'
require './item'
require './promotion_rule'

RSpec.describe Checkout do
  let(:item1) { Item.new('001', 'Red Scarf',	9.25) }
  let(:item2) { Item.new('002', 'Silver cufflinks',	45.00) }
  let(:item3) { Item.new('003', 'Silk Dress',	19.95) }
  let(:promotional_rules) do
    [
      ProductDiscount.new(item_code: '001', count: 2, new_price: 8.5),
      PercentDiscount.new(discount: 0.1, condition: 60.0)
    ]
  end
  subject(:checkout) { Checkout.new(promotional_rules) }

  describe '#total' do


    context 'Test1 - Basket: 001, 002, 003' do
      before do
        checkout.scan(item1)
        checkout.scan(item2)
        checkout.scan(item3)
      end

      it 'total price should be £66.78' do
        expect(checkout.total).to eq '£66.78'
      end
    end

    context 'Test2 - Basket: 001, 003, 001' do
      before do
        checkout.scan(item1)
        checkout.scan(item3)
        checkout.scan(item1)
      end

      it 'Total price expected: £36.95' do
        expect(checkout.total).to eq '£36.95'
      end
    end

    context 'Test3 - Basket: 001, 002, 001, 003' do
      before do
        checkout.scan(item1)
        checkout.scan(item2)
        checkout.scan(item1)
        checkout.scan(item3)
      end

      it 'Total price expected: £73.76' do
        expect(checkout.total).to eq '£73.76'
      end
    end
  end
end
