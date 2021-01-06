class CreateRoomOwnerships < ActiveRecord::Migration[6.0]
  def change
    create_table :room_ownerships do |t|
      t.belongs_to :user

      t.timestamps
    end

    change_table :rooms do |t|
      t.belongs_to :room_ownership
    end
  end
end
