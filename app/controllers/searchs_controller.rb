class SearchsController < ApplicationController
  def search
    # 検索に使用
    @city = params[:city_id]
    @prefecture = params[:prefecture_id]
    @content = params[:content]

    # 検索結果で使用
    @records = Post.search_for(@city,@prefecture,@content)
    @Pref_name = Prefecture.find(@prefecture).name
    @city_name = City.find(@city).name
  end
end
