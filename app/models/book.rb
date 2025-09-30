class Book < ApplicationRecord
  has_many :loans, dependent: :restrict_with_error
  belongs_to :category

  validates :author, presence: true
  validates :title, presence: true
  validates :status, presence: true
end