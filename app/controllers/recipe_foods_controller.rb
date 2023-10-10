class RecipeFoodsController < ApplicationController

  # GET /recipe_foods/new
  def new
    @recipe_food = RecipeFood.new
    @recipe = Recipe.find(params[:recipe_id])
  end

  # GET /recipe_foods/1/edit
  def edit
  @recipe_food = RecipeFood.find(params[:id])
  @recipe = Recipe.find(params[:recipe_id])
  @edit = true
  end

  # POST /recipe_foods or /recipe_foods.json
  def create
    @food = Food.find_by(name: params[:recipe_food][:food_name])
    if @food
      
      @quantity = @food.quantity - (params[:recipe_food][:quantity]).to_i
      @food.update(quantity: @quantity)
      @recipe_food = RecipeFood.new(quantity: params[:recipe_food][:quantity])
      @recipe = Recipe.find(params[:recipe_food][:recipe_id])
      @recipe_food.recipe = @recipe
      @recipe_food.food = @food
      if @recipe_food.save
       redirect_to recipe_url(@recipe), notice: 'Recipe ingredient was successfully added.'
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to new_recipe_food_url(@recipe_food), alert: 'Food not available, Add it first.'
    end
  end

  # PATCH/PUT /recipe_foods/1 or /recipe_foods/1.json
  def update
    @recipe_food = RecipeFood.find_by(params[:recipe_id])
    @old_quantity = @recipe_food.quantity 
   
    if @old_quantity > (params[:recipe_food][:quantity]).to_i
       @new_quantity = @old_quantity - (params[:recipe_food][:quantity]).to_i
    else
      @new_quantity = (params[:recipe_food][:quantity]).to_i - @old_quantity 
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

  # DELETE /recipe_foods/1 or /recipe_foods/1.json
  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @food = Food.find(@recipe_food.food_id)
    @quantity = @food.quantity + @recipe_food.quantity
    @food.update(quantity: @quantity)
    if @recipe_food.destroy
      redirect_to recipe_url(@recipe), notice: 'Recipe ingredient was successfully removed.'
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_name, :recipe_id)
  end
end
