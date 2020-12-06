class WordBroadcastJob < ApplicationJob
  queue_as :default

  def perform(word)
    ActionCable.server.broadcast word.room, word: render_word(word)
  end

  private

  def render_word(word)
    ApplicationController.renderer.render partial: "words/word", locals: { word: word }
  end

end
