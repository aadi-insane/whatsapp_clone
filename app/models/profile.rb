class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  has_many :chat_memberships, through: :user
  has_many :chats, through: :chat_memberships
end
