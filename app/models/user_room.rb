class UserRoom < ApplicationRecord
  belongs_to :chats
  belongs_to :rooms
end
