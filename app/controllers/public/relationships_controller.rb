class Public::RelationshipsController < ApplicationController
  # フォローする
  def create
    current_member.follow(params[:member_id])
    redirect_to request.referer
  end
  # フォローを外す
  def destroy
    current_member.unfollow(params[:member_id])
    redirect_to request.referer
  end
  # フォロー一覧
  def followings
    @member = Member.find(params[:member_id])
    @members = @member.followings
  end
  # フォロワー一覧
  def followers
    @member = Member.find(params[:member_id])
    @members = @member.followers
  end
end
