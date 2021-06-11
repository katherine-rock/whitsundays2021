class ContactsController < ApplicationController
    before_action :set_contact, only: %i[ show edit update destroy ]
    before_action :authenticate_user!
  
    def index
      @contacts = Contact.all
    end
  
    def show
    end
  
    def edit
    end
  
    def new
      @contact = Contact.new
    end
  
    def create
      @contact = Contact.new(contact_params)
  
      respond_to do |format|
      if @contact.save
          format.html { redirect_to @contact, notice: "Contact was successfully created." }
          format.json { render :show, status: :created, location: @contact }
      else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
      end
    end
  
    def update
      respond_to do |format|
        if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: "Contact has been successfully updated." }
        format.json { render :show, status: :ok, location: @contact }
        else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
    end
    end
  
    def destroy
      @contact.destroy
      respond_to do |format|
          format.html { redirect_to contacts_url, notice: "Contact has been successfully deleted." }
          format.json { head :no_content }
      end
    end
  
    private
  
    def set_contact
      @contact = Contact.find(params[:id])
    end
  
    def contact_params
      params.require(:contact).permit(:id, :contact, :firstname, :lastname, :category, :email, :phone, :company, :comment, :user_id).merge(user_id: current_user.id)
    end
end
