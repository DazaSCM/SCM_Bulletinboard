class PostsController < ApplicationController
  before_action :authorize_request

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.all
    render json: @posts, status: :ok
  end

  def all_posts
    @posts = Post.all
    render json: @posts, status: :ok
  end

  def post_search
    @posts = Post.where(title: params[:title])
    if @posts 
      render json: @posts, status: :ok
    else
      render json: {errors: "No posts found"}
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    render json: @post, status: :ok
  end

  def admin_show
    @post = Post.find(params[:id])
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

  def csv_create
    @user = User.find(params[:user_id])
    file = params[:csv_file]
    @rowarraydisp = CSV.read(file.path).drop(1)
    
    @rowarraydisp.each do |article|
      temp_params = {"title"=>article[0], "description"=>article[1], "status"=>article[2]}
      @posts = @user.posts.create(temp_params)
    end
    render json: @posts, status: :ok

  end

  def update
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post = @post.update(title: params[:title], description: params[:description], status: params[:status], updated_user_id: params[:user_id])
    render json: @post, status: :ok
  end

  def admin_update
    @post = Post.find(params[:id])
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
