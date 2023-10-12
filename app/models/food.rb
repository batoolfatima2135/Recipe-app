class Food < ApplicationRecord
  validates :name, :measurement_unit, :quantity, :price, presence: true
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
end
