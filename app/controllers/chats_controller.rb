class ChatsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_chat, only: [:show, :update, :destroy]

  def create
    @chat = Chat.new(chat_params)
    @chat.find_and_add_participants(params[:user_ids], current_user)
    if @chat.save
      render action: 'show', status: :created, location: @chat
    else
      render_json_error(@chat.errors.messages, :unprocessable_entity)
    end
  end

  def show
  end

  private

    def chat_params
      params.require(:chat).permit(:name)
    end

    def set_chat
      @chat = Chat.find(params[:id])
    end

end
