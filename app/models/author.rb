class Author < ApplicationRecord
  has_many :books # => plural

    validates :name, presence: true, uniqueness: true

  def first_published
    my_books = self.books.where.not(publication_year: nil)
    my_books = books.order(publication_year: :asc)

    if my_books.length == 0
      nil
    end

    first_book = my_books.first

    return first_book.publication_year
  end

  def last_published
    my_books = self.books.where.not(publication_year: nil)
    my_books = books.order(publication_year: :asc)

    if my_books.length == 0
      nil
    end

    last_book = my_books.last

    return last_book.publication_year
  end
end
