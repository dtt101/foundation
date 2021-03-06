class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    email: true
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
