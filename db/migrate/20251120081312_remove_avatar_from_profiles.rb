class RemoveAvatarFromProfiles < ActiveRecord::Migration[7.1]
  def change
    remove_column :profiles, :avatar, :string
  end
end
