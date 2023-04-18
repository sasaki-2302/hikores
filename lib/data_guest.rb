class GuestMember::DataGuest
  # https://qiita.com/Tanesaka/items/74d608d4d1a8a6c0a47a 参照
  # guestuserの投稿を削除
  def self.data_reset
    member = Member.find_by(email: "guest@example.com")
    member.posts.destroy_all
    member.comments.destroy_all
  end
end