class User < ApplicationRecord
  validates :full_name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :email, presence: true, uniqueness: true
  validates :loan_password, presence: true
end