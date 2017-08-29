class AddRecastTokenIndexFromUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :recast_sender_id, unique: true
  end
end
