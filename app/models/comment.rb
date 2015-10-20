class Comment < ActiveRecord::Base
	validates :content, presence: true 
	belongs_to :note
	belongs_to :user
end
