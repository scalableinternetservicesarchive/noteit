module UsersHelper

def cache_key_for_feed(feed_items)
   "feed/#{feed_items.count}/#{feed_items.maximum(:updated_at)}"
end	

def cache_key_for_feed_item(item)
	"note/#{item.id}/#{item.updated_at}"
end

end
