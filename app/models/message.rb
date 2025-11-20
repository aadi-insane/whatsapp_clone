class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  # after_create_commit { broadcast_message }

  # private

  # def broadcast_message
  #   ActionCable.server.broadcast("chat_#{self.chat.id}", {
  #     message: self.content,
  #     user_email: self.user.email
  #   })
  # end
end
