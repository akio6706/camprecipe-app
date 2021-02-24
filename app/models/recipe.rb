class Recipe < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :ingredients
  has_many :procedures
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :level
end
