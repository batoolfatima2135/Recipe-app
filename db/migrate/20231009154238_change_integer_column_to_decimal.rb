class ChangeIntegerColumnToDecimal < ActiveRecord::Migration[7.0]
  def change
     change_column :recipes, :cooking_time, :decimal, precision: 10, scale: 2
     change_column :recipes, :preparation_time, :decimal, precision: 10, scale: 2
  end
end
