require "test_helper"

describe BooksController do
  describe 'index' do

    it 'sends a success response when there are many books' do
      # Assumption instead of Arrange
      # Check your assumption
      Book.count.must_be :>, 0

      # Act
      get books_path

      # Assert
      must_respond_with :success
    end

    it 'sends a success response when there are no books' do
      # Arrange
      Book.destroy_all
      # Book.all.length.must_equal 0

      # Act
      get books_path

      # Assert
      must_respond_with :success
    end

  end

  describe 'new' do
    # Don't need to test with no books,
    # because this action doesn't even
    # look at the database

    it 'responds with success' do
      get new_book_path

      must_respond_with :success
    end

  end


  describe 'create' do
    it 'can add a valid book' do
      # Arrange
      book_data = {
        title: 'controller test book',
        author_id: Author.first.id
      }
      old_book_count = Book.count

      # Assumption
      Book.new(book_data).must_be :valid?

      # Act
      post books_path, params: { book: book_data }

      # Assert
      # ***The HTTP response below
      must_respond_with :redirect
      must_redirect_to books_path

      # ***Checking the changes to the
      # database below
      Book.count.must_equal old_book_count + 1
      Book.last.title.must_equal book_data[:title]
    end

    it "won't add an invalid book" do
      # Arrange
      book_data = {
        title: nil,
        author_id: Author.first.id
      }
      old_book_count = Book.count

      # Assumption
      Book.new(book_data).wont_be :valid?

      # Act
      post books_path, params: { book: book_data }

      # Assert
      must_respond_with :bad_request
      Book.count.must_equal old_book_count
    end
  end

  describe 'show' do
    it 'sends success if the book exists' do
      get book_path(Book.first)

      must_respond_with :success
    end

    it 'sends not_found if the book does not exist' do
      # Get an invalid book ID somehow
      # more than one way to do this
      book_id = Book.last.id + 1

      get book_path(book_id)

      must_respond_with :not_found
    end
  end

  describe 'edit' do
    it 'sends success if the book exists' do
      get edit_book_path(Book.first)

      must_respond_with :success
    end

    it 'sends not_found if the book does not exist' do
      book_id = Book.last.id + 1

      get edit_book_path(book_id)

      must_respond_with :not_found
    end
  end

  describe 'update' do
    it 'can update an existing book with valid data' do
      # Arrange
      book = Book.first
      book_data = book.attributes
      book_data[:title] = 'some updated title'

      # Assumption
      book.assign_attributes(book_data)
      book.must_be :valid?

      # Act
      patch book_path(book), params: { book: book_data }

      # Assert
      # ***The HTTP response below
      must_respond_with :redirect
      must_redirect_to book_path(book)

      # ***Checking the changes to the
      # database below, not from our local
      # variable book
      Book.first.title.must_equal book_data[:title]
      # ***OR you can do the below
      # book.reload
      # book.title.must_equal book_data[:title]
    end

    it 'sends bad_request for invalid data' do
      # Arrange
      book = Book.first
      book_data = book.attributes
      book_data[:title] = ""

      # Assumption
      book.assign_attributes(book_data)
      book.wont_be :valid?

      # Act
      patch book_path(book), params: { book: book_data }

      # Assert
      # ***The HTTP response below
      must_respond_with :bad_request

      # ***Checking the changes to the
      # database below, not from our local
      # variable book
      Book.first.title.wont_equal book_data[:title]
      # ***OR you can do the below
      # book.reload
      # book.title.wont_equal book_data[:title]
    end

    it 'sends not_found for a book that does not exist' do
      book_id = Book.last.id + 1

      patch book_path(book_id)

      must_respond_with :not_found
    end
  end

  describe 'destroy' do
    it 'destroys a real book' do
      # Arrange
      book_id = Book.first.id
      old_book_count = Book.count

      # Act
      delete book_path(book_id)

      # Assert
      must_respond_with :redirect
      must_redirect_to books_path

      Book.count.must_equal old_book_count - 1
      Book.find_by(id: book_id).must_be_nil
    end

    it 'sends not_found when the book D.N.E' do
      book_id = Book.last.id + 1
      old_book_count = Book.count

      delete book_path(book_id)

      must_respond_with :not_found
      Book.count.must_equal old_book_count
    end
  end

end
