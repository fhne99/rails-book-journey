class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :content, length: { maximum: 500 }
end
