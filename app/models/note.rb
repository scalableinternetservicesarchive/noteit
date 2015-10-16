class Note < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true
	belongs_to :user
	has_many :comments
	default_scope -> { order(created_at: :desc) }

end
