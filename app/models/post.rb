class Post < ApplicationRecord
  belongs_to :member
  has_many   :comments,   dependent: :destroy
  has_many   :favorites,  dependent: :destroy
  has_many   :prefectures,dependent: :destroy
end
