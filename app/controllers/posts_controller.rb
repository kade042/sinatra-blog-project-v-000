class PostsController < ApplicationController

  get '/posts' do
    if logged_in?
      erb :"posts/posts"
    else
      redirect "/login"
    end

  end

  post '/posts' do


    if logged_in? && Post.valid_params?(params)
      #binding.pry
      @post = current_user.posts.create(params[:post])
      @post.category = Category.create(name: params[:category]) unless params[:category].empty?
      @post.save

      redirect "/posts"
    else
      redirect "/posts/new"
    end
  end

  get '/posts/new' do
    #binding.pry
    if logged_in?
      erb :"posts/create_post"
    else
      redirect "/login"
    end
  end

  get '/posts/:id' do
    if logged_in?
      @post = Post.find_by(id: params[:id])

      erb :"posts/edit_post"
    else
      redirect '/login'
    end
  end

  patch '/posts/:id' do
    @post = user_posts.find_by(id: params[:id])

    if @post && !params["post"]["content"].empty?
      #binding.pry

      @post.update(params["post"])
      @post.category = Category.create(name: params[:category]) unless params[:category].empty?
      @post.save
      redirect '/posts'
    else
      redirect "/posts" #/#{@post.id}/edit"
    end
  end

  get '/posts/:id/edit' do
    #binding.pry
    if logged_in? &&
      @tweet = Post.find_by(id: params[:id])
      erb :"posts/edit_post"
    else
      redirect '/login'
    end

  end

  delete '/posts/:id/delete' do
    if logged_in?
      @user_posts = current_user.posts
      @post = @user_posts.find_by(id: params[:id])
      @post.delete if !@post.nil?
      redirect  '/posts'
    else
      redirect "/login"
    end

  end

  private
    def user_posts
      current_user.posts if logged_in?
    end

end
