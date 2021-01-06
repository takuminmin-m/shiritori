class RoomOwnership < ApplicationRecord
  belongs_to :user
  has_one :room
end
