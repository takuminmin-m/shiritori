class CreateRoomMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :room_memberships do |t|
      t.references :user
      t.references :room

      t.timestamps
    end
  end
end
