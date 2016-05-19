class Chat < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :participants, class_name: 'User'
  validates :participants, length: { minimum: 2, too_short: 'You should invite someone' }
  has_many :messages

  def find_and_add_participants(user_ids, current_user)
    users = user_ids.nil? ? [current_user] : user_ids.uniq.map{ |id| User.find_by_id(id) } << current_user
    users.each{ |user| participants << user unless participants.include?(user) }
  end

  def show_participant_ids
    participants.map(&:id)
  end

  def authorized_user?(user)
    participants.include?(user)
  end

  def count_unread_messages(user)
    (messages.map(&:id) - user.readings.map(&:message_id)).count
  end

  def make_readings(user)
    messages.each do |message|
      begin
        user.readings.create(message_id: message.id)
      rescue ActiveRecord::RecordNotUnique
        next
      end
    end
  end

end
