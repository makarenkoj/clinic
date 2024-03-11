class MessagesController < ApplicationController
  def create
    # binding.b
    @new_message = current_user&.messages&.build(strong_params)

    return unless @new_message&.save

    @new_message.broadcast_append_to @new_message.room, locals: { user: current_user }
    
  end

  private

  def strong_params
    params.require(:message).permit(:room_id, :body)
  end
end
