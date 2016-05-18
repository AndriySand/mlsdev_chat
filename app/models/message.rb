class Message < ActiveRecord::Base

  belongs_to :author, class_name: 'User'
  belongs_to :chat
  validates :body, :author_id, :chat_id, presence: true
  has_many :readings
  after_save :ensure_reading_for_author

  def ensure_reading_for_author
  	readings.create(user_id: author_id)
  end

end
