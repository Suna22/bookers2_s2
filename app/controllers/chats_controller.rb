class ChatsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @room = current_user.room_with(@user)
    @chat = current_user.chats.new(room_id: @room.id, body: params[:chat][:body])
    if @chat.save
      redirect_back(fallback_location: root_path)
    else
      @chats = @room.chats
      render "rooms/show"
    end
  end
end
