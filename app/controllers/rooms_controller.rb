class RoomsController < ApplicationController
  def create
    user_id = params[:user_id].to_i
    room = current_user.rooms.create!
    UserRoom.create!(user_id: user_id, room_id: room.id)
    redirect_to user_room_path(user_id)
  end

  def show
    @user = User.find(params[:user_id])
    @room = current_user.room_with(@user)
    @chats = @room.chats
    @chat = Chat.new()
  end
end
