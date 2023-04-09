class SearchsController < ApplicationController
  def search
    @city = params[:city_id]
    @prefecture = params[:prefecture_id]
    @content = params[:content]

    @records = Post.search_for(@city,@prefecture,@content)
  end
end
