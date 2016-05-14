class Chat < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :participants, class_name: 'User', dependent: :destroy
  validates :participants, length: { minimum: 2, too_short: 'You should invite someone' }

  def find_and_add_participants(user_ids, current_user)
    users = user_ids.nil? ? [] : user_ids.map{ |user_id| User.find_by_id(user_id) }
    users.each{ |user| participants << user } if users.any?
    participants << current_user
  end

  def show_participant_ids
    participants.map{|participant| participant.id}
  end

end
