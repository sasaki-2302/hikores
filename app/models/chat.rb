class Chat < ApplicationRecord
  belongs_to :member
  belongs_to :room

  validates :chat, presence: true, length: { maximum: 140 }
end
