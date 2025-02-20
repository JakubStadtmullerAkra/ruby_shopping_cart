# frozen_string_literal: true

class Item
  attr_accessor :code, :name, :price

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
  end
end
