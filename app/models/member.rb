class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts,     dependent: :destroy
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy
  # フォロー機能で使用　has_manyで仮の名前,class_nameで本来のモデル,foreign_keyで参照するカラムを指定
  has_many :followeres, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds,  class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローのviewで使用  上記の仮テーブルを通ってsourceで本来のカラムを参照する
  has_many :followings, through: :followeres, source: :followed
  has_many :followers,  through: :followeds,  source: :follower
  # DMで使用
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms
  # 通報機能で使用　has_manyで仮の名前,class_nameで本来のモデル,foreign_keyで参照するカラムを指定
  has_many :reporters, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reporteds, class_name: "Report", foreign_key: "reported_id", dependent: :destroy
  validates :name, length: { minimum: 2, maximum: 12 }

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
  # guestの投稿,コメント,いいね,フォロー,フォロワーを自動削除するメソッド
  # https://qiita.com/Tanesaka/items/74d608d4d1a8a6c0a47a　参照
  def self.data_reset
    member = Member.find_by(email: "guest@example.com")
    # destroy_allはRailsに元からあるメソッドで、対象の全削除ができる
    member.posts.destroy_all
    member.comments.destroy_all
    member.favorites.destroy_all
    member.followeres.destroy_all
    member.followeds.destroy_all
  end
end
