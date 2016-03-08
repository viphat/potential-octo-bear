# Main Controller
class BooksController < ApplicationController
  include ApplicationHelper

  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def get_books_json
    books = Book.export_to_json()
    render json: { books: books }
  end

  def search_by_title
    if (params[:title].present?)
      @books = Book.where('title ILIKE ?', "%#{params[:title]}%").order(:created_at)
      render json: @books,  each_serializer: BookSerializer
    end
  end

  def index
    @books = Book.order(:created_at).page(params[:page]).per(Settings.record_per_page)
    render json: @books,  each_serializer: BookSerializer,
           meta: {
             number_of_pages: @books.num_pages,
             current_page: @books.current_page,
             total_count: @books.total_count
           }
  end

  def filter_book_type
    book_type = params[:book_type]
    @books = Book.where(book_type: book_type)
                 .order(:created_at)
                 .page(params[:page])
                 .per(Settings.record_per_page)
    render json: @books,  each_serializer: BookSerializer,
           meta: {
             number_of_pages: @books.num_pages,
             current_page: @books.current_page,
             total_count: @books.total_count
           }
  end

  def get_random_book
    @books = Book.where.not(:image_url => nil).order('RANDOM()').take(5)
    render json: @books,  each_serializer: BookSerializer
  end

  def filter_author_and_book_type
    author = params[:author]
    book_type = params[:book_type]
    @books = Book.order(:created_at).where('author like ? And book_type = ?',
                        "%#{author}%",
                        book_type )
                 .page(params[:page])
                 .per(Settings.record_per_page)
    render json: @books,  each_serializer: BookSerializer,
           meta: {
             number_of_pages: @books.num_pages,
             current_page: @books.current_page,
             total_count: @books.total_count
           }
  end

  def authors_tag
    # .pluck tra ve Tat ca cac gia tri cua Cot :author trong bang Book
    authors = []
    Book.pluck(:author).each { |x|
      x.split(';').each { |e|
        authors << e.strip
      }
    }

    wf = Hash.new(0)
    authors.each do |word|
      wf[word] += 1
    end
    arr = []
    wf.each do |k,v|
      arr << { name: k, num_of_books: v }
    end
    render json: arr, root: false
  end

  def filter_author
    author = params[:author]
    @books = Book.order(:created_at).where('author like ?', "%#{author}%")
                 .page(params[:page])
                 .per(Settings.record_per_page)
    render json: @books,  each_serializer: BookSerializer,
           meta: {
             number_of_pages: @books.num_pages,
             current_page: @books.current_page,
             total_count: @books.total_count
           }
  end

  def show
    render json: @book, root: false
  end

  def load_book_details
    @book = Book.where('title = ?', params[:title]).first
    @book.review = markdown(@book.review)
    @book.image_url = @book.image_url.url
    show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      render json: @book, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, staus: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    render json: { message: 'Book was deleted' }
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title,
                                 :author,
                                 :image_url,
                                 :description,
                                 :book_type,
                                 :review,
                                 :id,
                                 :rating,
                                 :file
                                )
  end
end
