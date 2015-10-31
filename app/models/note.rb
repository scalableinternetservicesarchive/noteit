class Note < ActiveRecord::Base
	validates :title, presence: true, length: { maximum: 60 }
	validates :content, presence: true
	belongs_to :user
	has_many :comments
	default_scope -> { order(created_at: :desc) }
	acts_as_votable
	searchable do
    	text :title, :boost => 2
    	text :content
	end
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
