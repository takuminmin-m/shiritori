class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find(params[:room])
    stream_for room
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Word.create! content: data["word"], user_id: current_user.id, room_id: params["room"]
  end
end
