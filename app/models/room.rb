class Room < ApplicationRecord
  belongs_to :user
  has_many :messages, -> { sorted }, dependent: :destroy
  has_many :participants, dependent: :destroy

  before_create { self.title = SecureRandom.hex(3) }

  scope :public_rooms, -> { where(is_private: false) }
  scope :private_rooms, -> { where(is_private: true) }

  def self.create_private_room(users)
    private_room = Room.create(user: users[1], is_private: true)
    users.each do |user|
      Participant.create(user_id: user.id, room_id: private_room.id)
    end

    private_room
  end
end
