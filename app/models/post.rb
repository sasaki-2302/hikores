class Post < ApplicationRecord
  belongs_to :member
  belongs_to  :prefecture
  belongs_to  :city
  has_many   :comments,   dependent: :destroy
  has_many   :favorites,  dependent: :destroy


  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
  # 都道府県・市区町村・内容のうちどれで検索しているか判別し処理を分岐
  def self.search_for(city,prefecture,content)
    if prefecture == nil
      Post.where('body LIKE ?', '%'+content+'%')
    elsif content == nil && city == nil
      Post.where('prefecture_id LIKE ?', prefecture)
    else
      Post.where('city_id LIKE ?', city)
    end
  end
end
