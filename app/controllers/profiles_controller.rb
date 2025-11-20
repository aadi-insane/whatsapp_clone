class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all.includes(:user, :avatar_attachment).where.not(user: current_user).order(created_at: :asc)
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: 'Profile was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @profile = params[:id] ? Profile.find(params[:id]) : current_user.profile
    @chat = Chat.joins(:chat_memberships)
              .where(chat_memberships: { user_id: [current_user.id, @profile.user_id] })
              .group('chats.id')
              .having('COUNT(chats.id) = 2')
              .first
  end

  private

    def profile_params
      params.require(:profile).permit(:name, :bio, :avatar)
    end
end
