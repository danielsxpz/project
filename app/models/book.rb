class Book < ApplicationRecord
  has_many :loans, dependent: :restrict_with_error
  belongs_to :category

  validates :author, presence: true
  validates :title, presence: true
  validates :status, presence: true

  def active_loan
    loans.find_by(returned_at: nil)
  end
end