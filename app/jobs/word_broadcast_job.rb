class WordBroadcastJob < ApplicationJob
  queue_as :default

  def perform(word)
    RoomChannel.broadcast_to(word.room, render_word(word))
  end

  private

  def render_word(word)
    {
      content: word.content,
      user_name: User.find(word.user_id)[:name]
    }
  end

end
