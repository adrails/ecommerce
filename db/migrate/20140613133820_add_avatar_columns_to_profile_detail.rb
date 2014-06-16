class AddAvatarColumnsToProfileDetail < ActiveRecord::Migration
  def self.up
    add_attachment :profile_details, :avatar
  end

  def self.down
    remove_attachment :profile_details, :avatar
  end
end
