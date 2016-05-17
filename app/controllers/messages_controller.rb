class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    chat = Chat.find(params[:chat_id])
    render_json_error('You are not authorized', :forbidden) and
      return unless chat.authorized_user?(current_user)
    @message = chat.messages.new(message_params)
    if @message.save
      render action: 'show', status: :created
    else
      render_json_error(@message.errors.messages, :unprocessable_entity)
    end
  end

  def show
  end

  private

    def message_params
      params.require(:message).permit(:body, :author_id)
    end

end
