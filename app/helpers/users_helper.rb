module UsersHelper

def cache_key_for_feed(feed_items)
   "feed/#{feed_items.count}/#{feed_items.maximum(:updated_at)}"
end	

def cache_key_for_feed_item(item)
	"note/#{item.id}/#{item.updated_at}"
end

def cache_key_for_users(users)
	"users/#{users.count}/#{users.maximum(:updated_at)}"
end

def cache_key_for_user(user)
  	"user/#{user.id}/#{user.updated_at}"
end

def count_upvotes(user)
	notes =Note.where(user_id = user)
	count = 0
	user.notes.each do |note|
		count += note.votes_for.up.by_type(User).voters.count
	end
	return count
end

def count_downvotes(user)
	notes =Note.where(user_id = user)
	count = 0
	user.notes.each do |note|
		count += note.votes_for.down.by_type(User).voters.count
	end
	return count
end

end