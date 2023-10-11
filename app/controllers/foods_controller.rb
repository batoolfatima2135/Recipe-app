class FoodsController < ApplicationController
  before_action :set_food, only: %i[show destroy]
  before_action :authenticate_user!

  def index
    @foods = Food.where(user_id: current_user.id)
  end

  def show; end

  def new
    @food = Food.new
  end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id
    if @food.save
      redirect_to food_url(@food), notice: 'Food was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food.destroy
    redirect_to food_url, notice: 'Food was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
