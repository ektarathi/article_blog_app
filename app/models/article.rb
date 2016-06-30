class Article < ActiveRecord::Base
	validates :title, :body, presence: true
	has_many :comments

	def self.search(search)
	  where("title LIKE ?", "%#{search}%")
	end
end
