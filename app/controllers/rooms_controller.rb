class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[show update edit delete]

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
    @room = Room.new(room_params)
    if @room.save
      redirect_to rooms_path
    else
      render "new"
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
