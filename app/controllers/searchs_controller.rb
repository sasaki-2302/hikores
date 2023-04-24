class SearchsController < ApplicationController
  def search
    # 検索に使用
    @city = params[:city_id]
    @prefecture = params[:prefecture_id]
    @content = params[:content]
    # 検索結果で使用
    @records = Post.search_for(@city,@prefecture,@content).page(params[:page]).per(9)
    # 投稿時に使用
    @post = Post.new
    @posts = @records
  end
end
