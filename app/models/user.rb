class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # removed - :registerable,
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  has_many :activities
  has_many :links
  has_many :documents
  has_many :posts
  has_many :chats
  has_many :contacts
end