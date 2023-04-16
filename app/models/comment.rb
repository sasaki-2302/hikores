class Comment < ApplicationRecord
  belongs_to :member
  belongs_to :post
  validates :comment,  length: { minimum: 2, maximum: 100 }
end
