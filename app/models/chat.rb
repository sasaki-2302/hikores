class Chat < ApplicationRecord
  belongs_to :userroom
  belongs_to :room
end
