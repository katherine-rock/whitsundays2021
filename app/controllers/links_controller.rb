class LinksController < ApplicationController
    before_action :set_link, only: %i[ show edit update destroy ]
    before_action :authenticate_user!
    rescue_from Pundit::NotAuthorizedError, with: :unauthorised 

    def unauthorised
      flash[:alert] = "Sorry! You do not have access to do that."
      redirect_to links_path
    end
  
    def index
      @links = Link.all.order(:category)
    end
  
    def show
    end
  
    def edit
      authorize @link
    end
  
    def new
      @link = Link.new
    end
  
    def create
      @link = Link.new(link_params)
  
      respond_to do |format|
      if @link.save
          format.html { redirect_to @link, notice: "Link was successfully created." }
          format.json { render :show, status: :created, location: @link }
      else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @link.errors, status: :unprocessable_entity }
      end
      end
    end
  
    def update
      respond_to do |format|
        if @link.update(link_params)
        format.html { redirect_to @link, notice: "Link listing has been successfully updated." }
        format.json { render :show, status: :ok, location: @link }
        else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
        end
    end
    end
  
    def destroy
      authorize @link
      @link.destroy
      respond_to do |format|
          format.html { redirect_to links_url, notice: "Link has been successfully deleted." }
          format.json { head :no_content }
      end
    end
  
    private
  
    def set_link
      @link = Link.find(params[:id])
    end
  
    def link_params
      params.require(:link).permit(:link, :id, :title, :description, :category, :user_id).merge(user_id: current_user.id)
    end
  
end
