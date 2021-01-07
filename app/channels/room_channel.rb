class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find(params["room"])
    stream_for room
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    if !(have_membership?)
      return
    end
    set_room
    if data["word"] =~ /[^ぁ-んー]/
      send_message "ひらがなのみを使用してください"
    elsif data["word"][-1] == "ん"
      send_message "語尾に「ん」がついてはいけません"
    elsif data["word"] =~ /ー{2,}/
      send_message "「ー」が二つ以上重なってはいけません"
    elsif @room.words.exists?
      @last_word_content = @room.words.last.content
      if @last_word_content[-1] != data["word"][0]
        if @last_word_content[-1] == "ー"
          if @last_word_content[-2] == data["word"][0]
            post_word data["word"], params["room"]
            return
          else
            send_message "前の言葉が「ー」で終わる場合はその前の文字からはじめてください"
          end
        end
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

  def have_membership?
    if Room.find(params["room"]).room_memberships.find_by(user_id: current_user.id)
      true
    else
      false
    end
  end
end
