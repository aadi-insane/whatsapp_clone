class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.create(
      content: message_params[:content],
      user: current_user
    )

    html = render_to_string(
      partial: "messages/message",
      locals: {
        message: @message,
        current_user: current_user
      }
    )

    ActionCable.server.broadcast(
      "chat_#{@chat.id}",
      { html: html, message_id: @message.id, sender_id: @message.user.id }
    )

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_path(@chat) }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
