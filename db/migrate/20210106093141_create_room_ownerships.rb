class CreateRoomOwnerships < ActiveRecord::Migration[6.0]
  def change
    create_table :room_ownerships do |t|
      t.belongs_to :user

      t.timestamps
    end

    add_reference :rooms, :room_ownership, foreign_key: true
  end
end
