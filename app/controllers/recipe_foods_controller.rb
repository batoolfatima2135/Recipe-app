class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recipe_food = RecipeFood.new
    @recipe = Recipe.find(params[:recipe_id])
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @edit = true
  end

  def create
    @food = Food.find_by(name: params[:recipe_food][:food_name])
    @recipe = Recipe.find(params[:recipe_food][:recipe_id])
    if @food
      @recipe_food = RecipeFood.find_or_initialize_by(food_id: @food.id, recipe_id: @recipe.id)
      quantity_change = params[:recipe_food][:quantity].to_i
      if @recipe_food.quantity.nil?
        @recipe_food.quantity = quantity_change
      else
        @recipe_food.quantity += quantity_change
      end
      if @recipe_food.save
        @food.update(quantity: @food.quantity - quantity_change)
        redirect_to recipe_url(@recipe), notice: 'Recipe ingredient was successfully added.'
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to new_recipe_recipe_food_path(@recipe), alert: 'Food not available, Add it first.'
    end
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    @old_quantity = @recipe_food.quantity

    @new_quantity = if @old_quantity > (params[:recipe_food][:quantity]).to_i
                      @old_quantity - (params[:recipe_food][:quantity]).to_i
                    else
                      (params[:recipe_food][:quantity]).to_i - @old_quantity
                    end
    @recipe_food.update(quantity: params[:recipe_food][:quantity])
    @food = Food.find(@recipe_food.food_id)
    @quantity = @food.quantity - @new_quantity
    @food.update(quantity: @quantity)
    if @recipe_food.save
      redirect_to recipe_url(@recipe_food.recipe.id), notice: 'Igredient quantity was successfully updated.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @food = Food.find(@recipe_food.food_id)
    @quantity = @food.quantity + @recipe_food.quantity
    @food.update(quantity: @quantity)
    return unless @recipe_food.destroy

    redirect_to recipe_url(@recipe), notice: 'Recipe ingredient was successfully removed.'
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_name, :recipe_id)
  end
end
