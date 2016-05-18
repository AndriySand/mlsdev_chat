collection @chats
attributes :id, :name
attributes show_participant_ids: :user_ids
node(:unread_messages_count) { |chat| chat.count_unread_messages(current_user) }
