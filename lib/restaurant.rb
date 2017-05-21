require_relative './order.rb'
require_relative './menu.rb'
require_relative './display.rb'
require_relative './messager.rb'

class InvalidOption < StandardError; end
class BasketEmpty < StandardError; end

class Restaurant
  include Display

  attr_reader :current_order

  def initialize(menu = Menu.new, order = Order.new, messager = Messager.new, name = "Woahaca")
    @menu = menu
    @current_order = order
    @messager = messager
    print_welcome_message(name)
  end

  def view_menu
    @menu.show_menu
  end

  def add_order(item_number,quantity = 1)
    raise(InvalidOption) unless on_menu?(item_number)
    @current_order.add_dish(@menu.dishes[item_number - 1], quantity)
  end

  def remove_order(dish,quantity = 1)
    @current_order.remove_dish(dish,quantity)
  end

  def order_summary
    @current_order.review_order
  end

  def checkout
    raise(BasketEmpty) if empty_order?
    print_receipt(order_summary,@current_order.order_total)
    confirm_order
  end

  private

  def on_menu?(menu_number)
    return true if menu_number =~ /^[0-9]+$/
    return true unless menu_number.to_i > @menu.dishes.length
  end

  def empty_order?
    @current_order.basket.empty?
  end

  def confirm_order
    @messager.send_confirmation(@current_order.order_total)
    print_incoming_text_warning
  end


end
