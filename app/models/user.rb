class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :messages
  has_many :chat_memberships
  has_many :chats, through: :chat_memberships
  accepts_nested_attributes_for :profile
  after_create :create_profile

  private
    def create_profile
      Profile.create(user: self)
    end
end
