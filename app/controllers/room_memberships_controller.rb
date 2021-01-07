class RoomMembershipsController < ApplicationController
  before_action :set_room

  def create
    set_user
    unless have_ownership?(@room)
      redirect_to rooms_path, alert: "権限がないためその操作を完了できません"
      return
    end
    unless @user
      redirect_to edit_room_path(@room.id), alert: "ユーザーが見つかりませんでした"
      return
    end
    @room_membership = @room.room_memberships.build
    @room_membership.user = @user
    if @room_membership.save
      redirect_to edit_room_path(@room.id), notice: "ユーザーを追加しました"
    else
      redirect_to edit_room_path(@room.id), alert: "ユーザーを追加できませんでした"
    end
  end

  def destroy
    set_room_membership
    unless have_ownership?(@room)
      redirect_to rooms_path, alert: "権限がないためその操作を完了できません"
      return
    end
    if @room_membership.destroy
      redirect_to edit_room_path(@room.id), notice: "ユーザーを退出させました"
    else
      redirect_to edit_room_path(@room.id), alert: "ユーザーを退出させることができませんでした"
    end
  end

  private

  def set_user
    @user = User.find_by(name: params[:user_name])
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_room_membership
    @room_membership = RoomMembership.find(params[:id])
  end
end
