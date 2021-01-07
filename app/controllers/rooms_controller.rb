class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[show update edit delete destroy]

  def index
    @rooms = Room.all.order(:id)
  end

  def show
    @words = @room.words
  end

  def new
    @room = Room.new
  end

  def create
    @room_ownership = current_user.room_ownerships.build
    @room = @room_ownership.build_room(room_params)
    if @room_ownership.save && @room.save
      redirect_to rooms_path
    else
      render "new"
    end
  end

  def destroy
    if @room.room_ownership.user != current_user
      redirect_to rooms_path, alert: "権限がないためその操作を完了できません"
      return
    end

    if @room.destroy
      redirect_to rooms_path, notice: "削除しました"
    else
      redirect_to rooms_path, alert: "削除に失敗しました"
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
