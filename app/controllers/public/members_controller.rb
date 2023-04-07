class Public::MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to member_path(@member.id)
  end
  
  def favorites
    @member = Member.find(params[:id])
    # 上記メンバーのいいねを全て取得し、対応するpost_idも取得
    favorites = Favorite.where(member_id: @member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :profile_image)
  end
end
