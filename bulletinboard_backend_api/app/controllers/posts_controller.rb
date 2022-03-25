class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.all
    render json: @posts, status: :ok
  end

  def all_posts
    @posts = Post.all
    render json: @posts, status: :ok
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    render json: @post, status: :ok
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)
    if @post.save
      render json: @post, status: :ok
    else
      render json: @post.errors, status: unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post = @post.update(title: params[:title], description: params[:description], status: params[:status], updated_user_id: params[:user_id])
    render json: @post, status: :ok
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    render json: {status: "deleted"}, status: :ok
  end

  private
    def post_params
      params.permit(:title, :description, :status)
    end
end