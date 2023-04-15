class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # has_manyで仮の名前,class_nameで本来のモデル,foreign_keyで参照するカラムを指定
  has_many :followeres, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # viewで使用  上記の仮テーブルを通ってsourceで本来のカラムを参照する
  has_many :followings, through: :followeres, source: :followed
  has_many :followers,  through: :followeds,  source: :follower
  # DMで使用
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms
  validates :name, length: { minimum: 2, maximum: 10 }

  has_one_attached :profile_image

  # メンバーのプロフィール画像がなければno_imageを適応する
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  # フォローしたときの処理
  def follow(member_id)
    followeres.create(followed_id: member_id)
  end
  # フォローを外すときの処理
  def unfollow(member_id)
    followeres.find_by(followed_id: member_id).destroy
  end
  # フォローしていればtrueを返す
  def following?(member)
    followings.include?(member)
  end
  # is_deletedカラムがfalseかを確認
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  # ゲストメンバーを定義
  def self.guest
    # find_or_create_byはデータ検索と作成を自動で判別するRailsのメソッド
    find_or_create_by!(name: 'guest_member', email: 'guest@example.com') do |member|
      # ランダムな文字列を生成するRubyのメソッドの一種
      member.password = SecureRandom.urlsafe_base64
      # 名前をguestmemberに固定することでメンバーモデルで.guestの記述が使用できる
      member.name = 'guest_member'
    end
  end
end
