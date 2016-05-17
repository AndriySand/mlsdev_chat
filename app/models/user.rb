class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :chats
  has_many :messages, foreign_key: 'author_id'

end
