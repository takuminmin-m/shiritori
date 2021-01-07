class Room < ApplicationRecord
  belongs_to :room_ownership, dependent: :destroy
  has_many :words, dependent: :destroy
end
