#Creating a dish with name, price and optional description

class Dish

  attr_reader :name, :price

  def initialize(name,price)
    @name = name
    @price = price
  end

end
