class Checkout
  attr_accessor :items, :promotional_rules

  def initialize(promotional_rules)
    @items = []
    @promotional_rules = promotional_rules
  end

  def scan(item)
    items << item
  end

  def total
    base_price = items.sum(&:price)

    promotional_rules.each { |rule| base_price = rule.apply(items, base_price) }

    return "£#{base_price.round(2)}"
  end
end
