class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @words = Word.all
  end
end
