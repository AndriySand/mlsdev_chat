class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_chat, except: :show

  def create
    render_json_error('You are not authorized', :forbidden) and
      return unless @chat.authorized_user?(current_user)
    @message = @chat.messages.new(message_params)
    if @message.save
      render action: 'show', status: :created
    else
      render_json_error(@message.errors.messages, :unprocessable_entity)
    end
  end

  def show
  end

  def index
    @messages = @chat.show_unread_messages(current_user)
    render_json_error('There are no messages', :not_found) unless @messages.any?
  end

  private

    def message_params
      params.require(:message).permit(:body, :author_id)
    end

    def find_chat
      @chat = Chat.find(params[:chat_id])
    end

end
