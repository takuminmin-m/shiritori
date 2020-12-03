class Word < ApplicationRecord
  validates :content, presence: true
  after_create_commit { WordBroadcastJob.perform_later self }
  belongs_to :user
  belongs_to :room
end
