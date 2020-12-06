class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_for "room_channel_#{params["room"]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Word.create! content: data["word"], user_id: current_user.id, room_id: params["room"]
  end
end
