class SearchsController < ApplicationController
  def search
    # 検索に使用
    @city = params[:city_id]
    @prefecture = params[:prefecture_id]
    @content = params[:content]
    # 検索結果で使用　並び替えのため分岐
    if params[:old]
      @records = search_result.old.page(params[:page]).per(12)
    elsif params[:favorite_count]
      # kaminariの通常の書き方は配列には対応していないためエラーが出る　そのため Kaminari.paginate_array(配列) の記述で回避する必要がある
      @records = Kaminari.paginate_array(search_result.latest.favorite_count).page(params[:page]).per(12)
    elsif params[:comment_count]
      @records = Kaminari.paginate_array(search_result.latest.comment_count).page(params[:page]).per(12)
    elsif params[:pv_count]
      @records = Kaminari.paginate_array(search_result.latest.pv_count).page(params[:page]).per(12)
    else
      @records = search_result.latest.page(params[:page]).per(12)
    end
    @records_count = Post.search_for(@city,@prefecture,@content).count
    # 投稿時に使用
    @post = Post.new
    @posts = @records
  end

  private
  def search_result
    Post.search_for(@city,@prefecture,@content)
  end
end
