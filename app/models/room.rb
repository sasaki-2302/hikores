class Room < ApplicationRecord
  has_many :userrooms
  has_many :chats
end
