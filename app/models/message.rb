class Message < ActiveRecord::Base

  belongs_to :author, class_name: 'User'
  belongs_to :chat
  validates :body, :author_id, :chat_id, presence: true

end
