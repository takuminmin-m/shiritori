class AddUserRefAndRoomRefToWords < ActiveRecord::Migration[6.0]
  def change
    add_reference :words, :user, null: false, foreign_key: true
    add_reference :words, :room, null: false, foreign_key: true
    change_column_null :words, :user_id, false
    change_column_null :words, :room_id, false
  end
end
