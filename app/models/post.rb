class Post < ApplicationRecord
  belongs_to :member
  belongs_to  :prefecture
  belongs_to  :city
  has_many   :comments,   dependent: :destroy
  has_many   :favorites,  dependent: :destroy


  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
  # どの市区町村で検索したかIDで確認
  def self.search_for(city_id)
    Post.where('city_id LIKE ?', city_id)
  end

  def self.search_for(content)
    Post.where('body LIKE ?', '%'+content+'%')
  end
end
