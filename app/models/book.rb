class Book < ActiveRecord::Base
  extend Enumerize
  validates_presence_of :title, :author, :book_type
  validates :title, uniqueness: { case_sensitive: false }
  validates :title, length: { minimum: 4, maximum: 255 }
  mount_uploader :image_url, BookCoverUploader
  enumerize :book_type, in: [:paper, :ebook]

  def self.remove_accents(string)
    return nil if string.nil? || string.length == 0
    str = string.to_s
    str.downcase!
    str = str.gsub(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ|A|Á|À|Ạ|Ả|Ã|Â|Ấ|Ầ|Ậ|Ẫ|Ẩ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ/,"a")
    str = str.gsub(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ|E|È|É|Ẹ|Ẻ|Ẽ|Ê|Ế|Ề|Ể|Ễ|Ệ/,"e")
    str = str.gsub(/ì|í|ị|ỉ|ĩ|I|Í|Ì|Ị|Ỉ|Ĩ/,"i")
    str = str.gsub(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ|O|Ó|Ò|Ọ|Ỏ|Õ|Ô|Ố|Ồ|Ộ|Ổ|Ỗ|Ơ|Ớ|Ờ|Ợ|Ở|Ỡ/,"o")
    str = str.gsub(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ|U|Ú|Ù|Ụ|Ủ|Ũ|Ư|Ứ|Ừ|Ự|Ử|Ữ/,"u")
    str = str.gsub(/ỳ|ý|ỵ|ỷ|ỹ|Y|Ỳ|Ý|Ỵ|Ỷ|Ỹ/,"y")
    str = str.gsub(/đ|Đ/,"d")
    str = str.gsub(/!|@|%|\^|\*|\(|\)|\+|\=|\<|\>|\?|\/|,|\.|\:|\;|\'| |\"|\&|\#|\[|\]|~|$|_|-/," ")
    str.strip.split(" ").join("_")
  end

  def self.export_to_json
    res = []
    Book.all.find_each do |book|
      res.push(
         {
            title: book.title,
            author: book.author,
            image_url: book.image_url.url || '',
            book_type: book.book_type, # paper, ebook, online_course
            review: '',
            review_url: '',
            rating: book.rating,
            created_at: book.created_at.to_i * 1000,
            updated_at: book.updated_at.to_i * 1000,
            current_status: 'available', # available, lost, gave, lended
            borrower: '',
            reading_status: 'to_read' #to_read, reading, read,
          }
       )
      # Notes: { "nanh_trang" => { 1: "note 1", 2: "note 2" } }
    end
    res
  end

end
