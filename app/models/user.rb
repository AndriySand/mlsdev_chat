class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  validates :name, presence: true, uniqueness: true

end
