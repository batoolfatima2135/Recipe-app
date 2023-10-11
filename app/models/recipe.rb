class Recipe < ApplicationRecord
  validates :name, :cooking_time, :description, presence: true
  belongs_to :user
  has_many :recipe_foods
end
