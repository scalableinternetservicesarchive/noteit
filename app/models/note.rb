class Note < ActiveRecord::Base
	validates :title, presence: true, length: { maximum: 60 }
	validates :content, presence: true
	belongs_to :user
	has_many :comments
	default_scope -> { order(created_at: :desc) }
	acts_as_votable

end
