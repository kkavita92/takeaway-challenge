require 'order'

describe Order do
  subject(:order) { described_class.new }
  let(:menu_item) { double :dish, price: 2 }
  let(:menu_item2) { double :dish, price: 3}

  it 'allows customer to start with an empty basket' do
    expect(order.basket).to be_empty
  end

  describe '#add_dish' do
     it 'adds menu item to basket' do
       order.add_dish(menu_item)
       expect(order.basket).to eq ({ menu_item => 1 })
     end

     it 'allows customer to customise quantity of menu item in order' do
       order.add_dish(menu_item,4)
       expect(order.basket).to eq ({ menu_item => 4 })
     end
  end

  describe '#remove_dish' do
    it 'removes menu item from basket' do
      order.add_dish(menu_item)
      order.remove_dish(menu_item)
      expect(order.basket).to eq ({ menu_item => 0 })
    end

    it 'can only remove menu items which have been added to basket' do
      order.add_dish(menu_item)
      expect{ order.remove_dish(menu_item2) }.to raise_error("Not in basket")
    end
  end

  describe '#review_order' do
    it 'lets you view basket at any point while ordering' do
      order.add_dish(menu_item)
      expect(order.review_order).to eq order.basket
    end
  end

  describe '#clear_order' do
    it 'lets you clear basket at any point while ordering' do
      order.add_dish(menu_item)
      order.add_dish(menu_item2)
      order.clear_order
      expect(order.basket).to be_empty
    end

    it 'only lets you clear a non-empty basket' do
      expect{ order.clear_order }.to raise_error("Basket already empty")
    end
  end

  describe '#total_price' do
    it 'calculates price total for dishes in basket' do
      order.add_dish(menu_item)
      order.add_dish(menu_item2)
      expect(order.total_price).to eq 5
    end
  end

end
