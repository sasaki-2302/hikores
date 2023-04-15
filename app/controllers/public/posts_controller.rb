class Public::PostsController < ApplicationController
  before_action :who_is_sign_in?, only: [:edit, :update]

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      flash[:notice] = "投稿が完了しました"
      redirect_to request.referer
    else
      flash[:error] = "投稿に失敗しました"
      redirect_to request.referer
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :member_id, :prefecture_id, :city_id)
  end

  def who_is_sign_in?
    # 未ログイン状態ならrootへ遷移させる
    if !member_signed_in? && !admin_signed_in?
      redirect_to request.referer
    else
      @post = Post.find(params[:id])
      # 管理者でログイン中または現在ログイン中のメンバーが投稿した内容か確認
      unless admin_signed_in? || @post.member.id == current_member.id
        redirect_to request.referer
      end
    end
  end
end
