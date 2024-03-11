class RoomsController < ApplicationController
  def index
    @new_room = Room.new
    @rooms = Room.all
  end

  def create
    @new_room = current_user&.rooms&.build
    if @new_room&.save
      @new_room.broadcast_append_to :rooms
    end

    # return unless @new_room&.save

    # redirect_to room_path(@new_room.title), notice: t('controllers.appointments.created')
    
  end

  def show
    @room = Room.find_by!(title: params[:title])
    @messages = @room.messages
    @new_message = current_user&.messages&.build(room: @room)
  end

  def create_private_room
    users = params[:user_ids].split(',').map { |id| User.find(id) }
    @private_room = Room.new(user: users[0], is_private: true)
    
    if @private_room.save
      users.each do |user|
        Participant.create(user_id: user.id, room_id: @private_room.id)
      end
    end

    redirect_to room_path(@private_room.title), notice: t('controllers.appointments.created')
  end
end
