class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[show update edit delete destroy]

  def index
  end

  def show
    unless have_membership?(@room)
      redirect_to rooms_path, alert: "権限がないためその操作を完了できません"
      return
    end
    @words = @room.words
  end

  def new
    @room = Room.new
  end

  def create
    @room_ownership = current_user.room_ownerships.build
    @room = @room_ownership.build_room(room_params)
    @room_membership = @room.room_memberships.build
    @room_membership.user = current_user
    if @room_ownership.save && @room.save && @room_membership.save
      redirect_to rooms_path
    else
      render "new"
    end
  end

  def destroy
    unless have_ownership?(@room)
      redirect_to rooms_path, alert: "権限がないためその操作を完了できません"
      return
    end

    if @room.destroy
      redirect_to rooms_path, notice: "削除しました"
    else
      redirect_to rooms_path, alert: "削除に失敗しました"
    end
  end

  def edit
    unless have_ownership?(@room)
      redirect_to rooms_path, alert: "権限がないためその操作を完了できません"
      return
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
