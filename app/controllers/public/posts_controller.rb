class Public::PostsController < ApplicationController
  before_action :who_is_sign_in?, only: [:edit, :update]

  def index
    if params[:old]
      @posts = Post.old.page(params[:page])
    elsif params[:favorite_count]
      # kaminariの通常の書き方は配列には対応していないためエラーが出る　そのため Kaminari.paginate_array(配列) の記述で回避する必要がある
      @posts = Kaminari.paginate_array(Post.latest.favorite_count).page(params[:page])
    elsif params[:comment_count]
      @posts = Kaminari.paginate_array(Post.latest.comment_count).page(params[:page])
    elsif params[:pv_count]
      @posts = Kaminari.paginate_array(Post.latest.pv_count).page(params[:page])
    else
      @posts = Post.latest.page(params[:page])
    end
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      flash[:notice] = "投稿が完了しました"
      redirect_to search_path(prefecture_id: @post.prefecture.id, city_id: @post.city.id)
    else
      flash[:error] = "投稿に失敗しました"
      redirect_to request.referer
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    impressionist(@post, nil, unique: [:session_hash])
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to post_path(@post.id)
    else
      flash[:error] = "投稿を編集できませんでした"
      redirect_to edit_post_path(@post.id)
    end
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
    # 未ログイン状態なら元のページへ遷移させる
    if !member_signed_in? && !admin_signed_in?
      redirect_to post_path(params[:id])
    else
      @post = Post.find(params[:id])
      # 管理者でログイン中または現在ログイン中のメンバーが投稿した内容か確認
      unless admin_signed_in? || @post.member.id == current_member.id
        redirect_to post_path(params[:id])
      end
    end
  end
end
