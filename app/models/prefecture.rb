class Prefecture < ApplicationRecord
  has_many  :posts
  has_many  :cities
  # case_sensitive: false　大文字、小文字を区別しない
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
