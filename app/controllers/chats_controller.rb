class ChatsController < ApplicationController
    before_action :set_chat, only: %i[ show edit update destroy ]
    before_action :authenticate_user!
  
    def index
      @chats = Chat.all.sort.reverse
    end
  
    def show
    end
  
    def edit
    end
  
    def new
      @chat = Chat.new
    end
  
    def create
      @chat = Chat.new(chat_params)
  
      respond_to do |format|
      if @chat.save
          format.html { redirect_to @chat, notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @chat }
      else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
      end
    end
  
    def update
      respond_to do |format|
        if @chat.update(chat_params)
        format.html { redirect_to @chat, notice: "Comment has been successfully updated." }
        format.json { render :show, status: :ok, location: @chat }
        else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
        end
    end
    end
  
    def destroy
      @chat.destroy
      respond_to do |format|
          format.html { redirect_to chats_url, notice: "Comment has been successfully deleted." }
          format.json { head :no_content }
      end
    end
  
    private
  
    def set_chat
      @chat = Chat.find(params[:id])
    end
  
    def chat_params
      params.require(:chat).permit(:id, :comment, :user_id).merge(user_id: current_user.id)
    end
  
end
