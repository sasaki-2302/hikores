class Public::MembersController < ApplicationController
  before_action :who_is_sign_in?, only: [:edit, :update]

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

  def who_is_sign_in?
    member = Member.find(params[:id])
    # 未ログイン状態かを確認
    if !member_signed_in? && !admin_signed_in?
      redirect_to posts_path
    elsif
      # 管理者でログイン中または現在ログイン中のメンバーが投稿した内容か確認
      unless admin_signed_in? || member.id == current_member.id
        redirect_to posts_path
      end
    end
  end
end
