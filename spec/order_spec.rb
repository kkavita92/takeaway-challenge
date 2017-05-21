require 'order'

describe Order do
  subject(:order) { described_class.new }
  let(:menu_item) { double :menu_item, name: 'Taco', price: 5 }
  let(:menu_item2) { double :menu_item }

  it 'allows customer to start with an empty basket' do
    expect(order.basket).to be_empty
  end

  describe '#add_dish' do
     it 'adds menu item to basket' do
       order.add_dish(menu_item)
       expect(order.basket).to eq ({menu_item => 1})
     end

     it 'allows customer to customise quantity of menu item in order' do
       order.add_dish(menu_item,4)
       expect(order.basket).to eq ({menu_item => 4})
     end
  end

  describe '#remove_dish' do
    it 'removes menu item from basket' do
      order.add_dish(menu_item)
      order.remove_dish(menu_item)
      expect(order.basket).to eq ({menu_item => 0})
    end

    it 'can only remove menu items which have been added to basket' do
      order.add_dish(menu_item)
      expect{ order.remove_dish(menu_item2) }.to raise_error("Not in basket")
    end

  end

end
