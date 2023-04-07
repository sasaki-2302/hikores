class Post < ApplicationRecord
  belongs_to :member
  has_many   :comments,   dependent: :destroy
  has_many   :favorites,  dependent: :destroy

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
  # https://qiita.com/yuhi_taka/items/d607e1a46b342c205f96　参照
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to  :prefecture
  belongs_to  :city
  # id_1は空データのため保存できないようにする
  validates :prefecture_id, numericality: { other_than: 1}
  validates :city_id, numericality: { other_than: 1}
end
