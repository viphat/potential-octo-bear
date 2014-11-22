class BookSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :author, :description, :image_url, :book_type, :review, :url, :rating

  def url
    book_path(object)
  end
end
