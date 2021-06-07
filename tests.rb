require 'byebug'
require 'colorize'
require './checkout.rb'
require './item.rb'
require './promotion_rule.rb'

def test(value, expected)
  if value == expected
    puts "Test passed!".green
    puts "Value #{value} is equal #{expected}".green
  else
    puts "Test passed!".red
    puts "Value #{value} is not equal #{expected}".red
  end
end

# Create Items
item1 = Item.new("001", "Red Scarf",	9.25)
item2 = Item.new("002", "Silver cufflinks",	45.00)
item3 = Item.new("003", "Silk Dress",	19.95)

# Create promotional rules


promotional_rules = [
  ProductDiscount.new(item_code: "001", count: 2, new_price: 8.5),
  PercentDiscount.new(discount: 0.1, condition: 60.0)
]

# tests

puts "Test1:"
puts "Basket: 001, 002, 003"
puts "Total price expected: £66.78"

co1 = Checkout.new(promotional_rules)
co1.scan(item1)
co1.scan(item2)
co1.scan(item3)
test(co1.total, "£66.78")


puts "Test2:"
puts "Basket: 001, 003, 001"
puts "Total price expected: £36.95"

co2 = Checkout.new(promotional_rules)
co2.scan(item1)
co2.scan(item3)
co2.scan(item1)
test(co2.total, "£36.95")

puts "Test 3"
puts "Basket: 001, 002, 001, 003"
puts "Total price expected: £73.76"

co3 = Checkout.new(promotional_rules)
co3.scan(item1)
co3.scan(item2)
co3.scan(item1)
co3.scan(item3)
test(co3.total, "£73.76")
