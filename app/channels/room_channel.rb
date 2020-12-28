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
    if data["word"][-1] == "ん"
      send_message("語尾に「ん」がついてはいけません")
    elsif !(@room.words.exists?)
      Word.create! content: data["word"], user_id: current_user.id, room_id: params["room"]
    elsif @room.words.last.content[-1] == data["word"][0]
      Word.create! content: data["word"], user_id: current_user.id, room_id: params["room"]
    else
      send_message("この言葉はルールに適合していません")
    end
  end


  private

  def set_room
    @room = Room.find(params["room"])
  end

  def send_message(message)
    UserMessageBroadcastJob.perform_later message, current_user
  end
end
