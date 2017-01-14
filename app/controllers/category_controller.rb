class CategoryController < ApplicationController

  get '/category/:id' do
    @category = Category.find_by(id: params[:id])
    @posts = Post.where(category_id: @category.id)
    #binding.pry
    erb :'categories/show'
  end
end
