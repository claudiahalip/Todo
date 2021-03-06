class User < ApplicationRecord

    has_many :tasks
    has_secure_password

    validates :username, uniqueness: true
    validates :username, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
end
