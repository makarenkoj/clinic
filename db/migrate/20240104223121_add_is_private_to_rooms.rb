class AddIsPrivateToRooms < ActiveRecord::Migration[7.0]
  def up
    change_table :rooms do |t|
      t.boolean :is_private, default: false
    
      Room.all.each do |room|
        room.is_private = false
      end
    end
  end

  def down
    remove_column :rooms, :is_private
  end
end
