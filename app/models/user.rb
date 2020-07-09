class User < ActiveRecord::Base
    has_secure_password
    has_many :recipes
    validates :email, uniqueness: true
    validates :username, uniqueness: true
end