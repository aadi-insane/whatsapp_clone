class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    # @chats = current_user.chats.includes(:users).order('updated_at DESC')
    @chats = current_user.chats
                     .includes(users: { profile: { avatar_attachment: :blob } })
                     .order(updated_at: :desc)
  end

  def show
    logger.debug "ChatsController#show - params[:id]: #{params[:id]}"
    @chat = Chat.includes(
      # :chat_memberships,
      # users: { profile: { avatar_attachment: :blob } },
      users: :profile,
      messages: { user: { profile: { avatar_attachment: :blob } } }
    ).find(params[:id])
    # Ensure current_user is a member of this chat
    unless @chat.users.include?(current_user)
      redirect_to chats_path, alert: "You are not authorized to view this chat."
    end
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      # Add current user to the chat
      @chat.chat_memberships.create(user: current_user)
      redirect_to @chat, notice: 'Chat was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def create_direct
    recipient = User.find(params[:recipient_id])

    # Find an existing direct chat between current_user and recipient
    # A direct chat has exactly two members
    @chat = Chat.joins(:chat_memberships)
                .group('chats.id')
                .having('COUNT(chat_memberships.id) = 2')
                .where(chat_memberships: { user_id: [current_user.id, recipient.id] })
                .first

    unless @chat
      @chat = Chat.create!(name: "Direct Chat") # Name can be dynamic or hidden for direct chats
      @chat.chat_memberships.create!(user: current_user)
      @chat.chat_memberships.create!(user: recipient)
    end

    redirect_to chat_path(@chat)
  end

  private

  def chat_params
    params.require(:chat).permit(:name) # user_ids are handled by chat_memberships
  end
end

