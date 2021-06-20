class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :unauthorised 

  def unauthorised
    flash[:alert] = "Sorry! You do not have access to do that."
    redirect_to documents_path
  end

  def index
    @documents = Document.all
  end

  def show
  end

  def edit
    authorize @document
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)

    respond_to do |format|
    if @document.save
        format.html { redirect_to @document, notice: "Document was successfully created." }
        format.json { render :show, status: :created, location: @document }
    else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
    end
    end
  end

  def update
    respond_to do |format|
      if @document.update(document_params)
      format.html { redirect_to @document, notice: "Document listing has been successfully updated." }
      format.json { render :show, status: :ok, location: @document }
      else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @document.errors, status: :unprocessable_entity }
      end
  end
  end

  def destroy
    authorize @document
    @document.destroy
    respond_to do |format|
        format.html { redirect_to documents_url, notice: "Document has been successfully deleted." }
        format.json { head :no_content }
    end
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:file, :document, :id, :title, :description, :category, :user_id).merge(user_id: current_user.id)
  end
end
