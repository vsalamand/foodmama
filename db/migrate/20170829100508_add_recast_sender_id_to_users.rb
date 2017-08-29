class AddRecastSenderIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column(:users, :recast_sender_id, :string)
  end
end
