class Book < ActiveRecord::Base
  extend Enumerize
  validates_presence_of :title, :author, :book_type
  validates :title, :uniqueness => { case_sensitive: false }
  mount_uploader :image_url, BookCoverUploader
  enumerize :book_type, in: [:paper, :ebook]

end
