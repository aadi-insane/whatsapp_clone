class Chat < ApplicationRecord
  validates :name, presence: true

  has_many :messages, dependent: :destroy
  has_many :chat_memberships, dependent: :destroy
  has_many :users, through: :chat_memberships
end
