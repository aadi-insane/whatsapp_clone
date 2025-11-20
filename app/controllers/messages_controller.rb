# class MessagesController < ApplicationController
#   def create
#     @chat = Chat.find(params[:chat_id])
#     @message = @chat.messages.new(message_params)
#     @message.user = current_user

#     if @message.save
#       ActionCable.server.broadcast("chat_#{@chat.id}",
#         {
#           message: @message.content,
#           user_email: @message.user.email
#         })
#       head :ok
#     else
#       head :unprocessable_entity
#     end
#   end

#   private

#   def message_params
#     params.require(:message).permit(:content)
#   end
# end

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.create(
      content: message_params[:content],
      user: current_user
    )

    # Broadcast new message to ActionCable
    ActionCable.server.broadcast(
      "chat_#{@chat.id}",
      {
        message: @message.content,
        user_name: @message.user.profile.name,
        user_email: @message.user.email,
        message_id: @message.id
      }
    )

    respond_to do |format|
      format.turbo_stream   # real-time update
      format.html { redirect_to chat_path(@chat) }  # fallback to avoid UnknownFormat
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
