class Book < ApplicationRecord
  belongs_to :category

  validates :author, presence: true
  validates :title, presence: true
  validates :status, presence: true
end