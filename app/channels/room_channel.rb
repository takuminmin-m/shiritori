class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find(params["room"])
    stream_for room
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    set_room
    if !(@room.words.exists?)
      Word.create! content: data["word"], user_id: current_user.id, room_id: params["room"]
    elsif @room.words.last.content[-1] == data["word"][0]
      Word.create! content: data["word"], user_id: current_user.id, room_id: params["room"]
    end
  end


  private

  def set_room
    @room = Room.find(params["room"])
  end
end
