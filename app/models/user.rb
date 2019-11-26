class User < ApplicationRecord
    has_secure_password
    has_many :todos, dependent: :destroy
    validates :email, presence: true
    validates :password, presence: true 
    validates_uniqueness_of :email
end
