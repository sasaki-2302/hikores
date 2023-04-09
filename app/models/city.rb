class City < ApplicationRecord
  belongs_to  :prefecture
  has_many  :posts

  validates :name, presence: true
end
