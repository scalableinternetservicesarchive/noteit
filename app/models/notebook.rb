class Notebook < ActiveRecord::Base
  belongs_to :user
  has_many :notes
  validates :title, presence: true
  default_scope -> { order(created_at: :desc) }
end
