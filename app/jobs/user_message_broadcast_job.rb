class UserMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, user)
    UserMessageChannel.broadcast_to(user, render_message(message))
  end

  private

  def render_message(message)
    {
      message: message
    }
  end
end
