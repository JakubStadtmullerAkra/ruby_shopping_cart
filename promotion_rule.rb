# frozen_string_literal: true

class PromotionRule
  def apply(items, base_price)
    raise NotImplementedError
  end
end

class PercentDiscount < PromotionRule
  attr_accessor :discount, :condition

  def initialize(discount:, condition:)
    @discount = discount
    @condition = condition

    super()
  end

  def apply(_items, base_price)
    return base_price - base_price * discount if base_price >= condition

    base_price
  end
end

class ProductDiscount < PromotionRule
  attr_accessor :item_code, :count, :new_price

  def initialize(item_code:, count:, new_price:)
    @item_code = item_code
    @count = count
    @new_price = new_price

    super()
  end

  def apply(items, base_price)
    discounted_items = items.select { |item| item.code == item_code }
    if discounted_items.size >= count
      discount = discounted_items.sum(&:price) - discounted_items.count * new_price

      return base_price - discount
    end

    base_price
  end
end
