class Public::MembersController < ApplicationController
  before_action :who_is_sign_in?,     only: [:edit, :update]
  before_action :ensure_guest_member, only: [:edit]

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
    flash[:notice] = "情報を更新しました"
    redirect_to request.referer
  end

  def favorites
    @member = Member.find(params[:id])
    # 上記メンバーのいいねを全て取得し、対応するpost_idも取得
    favorites = Favorite.where(member_id: @member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def hide
    @member = current_member
    # is_deleteをtrueに変更する
    @member.update(is_deleted: true)
    # ログアウトさせrootに飛ばす
    reset_session
    flash[:notice] = "ご利用ありがとうございました。アカウント復旧の際は運営までお問い合わせ下さい。"
    redirect_to root_path
  end

  private
  def member_params
    params.require(:member).permit(:name, :email, :profile_image, :is_deleted)
  end
  # 投稿メンバー以外は投稿の編集ページへアクセスできないようにする
  def who_is_sign_in?
    member = Member.find(params[:id])
    # 未ログイン状態かを確認
    if !member_signed_in? && !admin_signed_in?
      redirect_to members_path
    else
      # 管理者でログイン中または現在ログイン中のメンバーか確認
      unless admin_signed_in? || member.id == current_member.id
        redirect_to members_path
      end
    end
  end

  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.name == "guest_member"
      redirect_to root_path , notice: 'ゲストメンバーはプロフィールの編集を行えません。'
    end
  end
end
