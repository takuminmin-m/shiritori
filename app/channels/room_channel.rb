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
    if !(data["word"] =~ /\p{Hiragana}/)
      send_message "ひらがなのみを使用してください"
    elsif data["word"][-1] == "ん"
      send_message "語尾に「ん」がついてはいけません"
    elsif @room.words.exists?
      if @room.words.last.content[-1] != data["word"][0]
        send_message "前の言葉の最後の文字ととこの言葉の最初の文字が一致していません"
      else
        post_word data["word"], params["room"]
      end
    else
      post_word data["word"], params["room"]
    end
  end


  private

  def set_room
    @room = Room.find(params["room"])
  end

  def send_message(message)
    UserMessageBroadcastJob.perform_later message, current_user
  end

  def post_word(word, room_id)
    Word.create! content: word, user_id: current_user.id, room_id: room_id
  end
end
