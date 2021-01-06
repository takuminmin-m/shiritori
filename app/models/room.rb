class Room < ApplicationRecord
  belongs_to :room_ownership
  has_many :words
end
