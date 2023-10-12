class GeneralShopingController < ApplicationController
  before_action :authenticate_user!
  def index
    @food_items = Food.where('quantity < 0')
    @total_amount = 0
    @count = 0
    @food_items.each do |food_item|
      food_item.quantity = food_item.quantity.negative? ? food_item.quantity.abs : food_item.quantity
      amount = food_item.quantity * food_item.price
      @total_amount += amount
      @count += 1
    end
  end
end
