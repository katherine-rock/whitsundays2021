class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :unauthorised 

    def unauthorised
      flash[:alert] = "Sorry! You do not have access to do that."
      redirect_to posts_path
    end

  def index
    @posts = Post.order(:created_at).reverse_order
  end

  def show
  end

  def edit
    authorize @post
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
    if @post.save
        format.html { redirect_to @post, notice: "Photo post was successfully created." }
        format.json { render :show, status: :created, location: @post }
    else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
    end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
      format.html { redirect_to @post, notice: "Photo post has been successfully updated." }
      format.json { render :show, status: :ok, location: @post }
      else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @post.errors, status: :unprocessable_entity }
      end
  end
  end

  def destroy
    authorize @post
    @post.destroy
    respond_to do |format|
        format.html { redirect_to posts_url, notice: "Photo post has been successfully deleted." }
        format.json { head :no_content }
    end
  end 

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:id, :post, :title, :comment, :user_id, :photo).merge(user_id: current_user.id)
  end
end
