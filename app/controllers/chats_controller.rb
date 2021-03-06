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
    if @chat.authorized_user?(current_user)
      @chat.make_readings(current_user)
    else
      render_json_error('You are not authorized', :forbidden)
    end
  end

  def index
    @chats = Chat.includes(:participants).select{|chat| chat.authorized_user?(current_user)}
    render_json_error('There are no chats', :not_found) unless @chats.any?
  end

  def update
    render_json_error('You are not authorized', :forbidden) and
      return unless @chat.authorized_user?(current_user)
    @chat.find_and_add_participants(params[:user_ids], current_user)
    if @chat.update(chat_params)
      render action: 'show', status: :ok
    else
      render_json_error(@chat.errors.messages, :unprocessable_entity)
    end
  end

  private

    def chat_params
      params.require(:chat).permit(:name)
    end

    def set_chat
      @chat = Chat.find(params[:id])
    end

end
