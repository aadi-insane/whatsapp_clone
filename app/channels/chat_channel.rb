class ChatChannel < ApplicationCable::Channel
  def subscribed
    @chat = Chat.find(params[:chat_id])
    
    unless @chat.users.include?(current_user)
      reject
    end
    
    stream_from "chat_#{@chat.id}"
  end
  
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
