class Notebook < ActiveRecord::Base
  belongs_to :user
  has_many :notes
  validates :title, presence: true, length: { maximum: 60 }
  default_scope -> { order(created_at: :desc) }
end
