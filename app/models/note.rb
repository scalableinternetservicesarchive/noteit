class Note < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true
	belongs_to :user
	belongs_to :notebook
	has_many :comments
	default_scope -> { order(created_at: :desc) }
	acts_as_votable
	searchable do
    	text :title, :boost => 2
    	text :content
	end
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment :avatar, content_type: { content_type: ["application/pdf", /\Aimage/] }
end
