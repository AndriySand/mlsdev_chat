class Reading < ActiveRecord::Base

  belongs_to :user
  belongs_to :message

end
