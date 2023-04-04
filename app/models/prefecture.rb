class Prefecture < ApplicationRecord
  belongs_to :post
  has_many   :cities
end
