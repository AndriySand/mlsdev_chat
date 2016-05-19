collection @users
attributes :id, :name
node(:messages_count) { |user| user.messages.count }
