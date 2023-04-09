class SearchsController < ApplicationController
  def search
    @content = params[:content]
    @prefecture = params[:prefecture_id]
    @city = params[:city_id]
    if @content == nil
      @records = Post.search_for(@city)
    else
      @records = Post.search_for(@content)
    end
  end
end
