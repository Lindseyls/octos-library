require "test_helper"

describe Book do

  describe "Validations" do
    # all validations pass
    before do
      # Arrange
      # *** We need an author for a book, so add one to the
      # test DB. Use create! to fail fast - we aren't
      # interested in the author, but we need our
      # tests to be invalid if we can't have one
      # author = Author.create!(name: "test author")

      # *** After we create the fixture data, we can
      # elimiate the instant with create! above and
      # just update the below author reference to Author.first
      # *** If you want a specific author then you can write
      # the below code
      # There are a variety of ways to access fixture data
      # Author.find_by(name: "Sandi Metz")
      # author = authors(:metz)
      # author = Author.first
      # @book = Book.new(title: "test book", author: author)

      # This will NOT work
      # *** IDs are assigned at random, so this will not work
      # Author.find(3)

      @book = Book.new(title: "test book", author: Author.first)
    end

    it "can be created with all required fields" do
      # Act
      result = @book.valid?

      # Assert
      result.must_equal true

      # Note: Don't need to do test line like below
      # @book.title.must_equal "test book"
      # b/c this is already implied when we created the
      # book and if the result is valid then the title
      # is there. Also, we didn't write the code that
      # saves these values
    end


    # no title -> fail
    it "is invalid without a title" do
      @book.title = nil

      result = @book.valid?

      result.must_equal false
      @book.errors.messages.must_include :title
    end

    # duplicate title -> fail
    it "is invalid with a duplicate title" do
      # title = "duplicate"
      # Book.create!(title: title, author: Author.first)
      # @book.title = title
      # *** After the fixture data is created for genre,
      # the above code can be written as below.

      dup_book = Book.first
      @book.title = dup_book.title

      result = @book.valid?

      result.must_equal false
      @book.errors.messages.must_include :title
    end

  end


  describe "relations" do
    before do
      @book = Book.new(title: 'test book')
    end
    # author
    it "connects author and author_id" do
      # Arrange
      # author = Author.create!
      # once we create the seed data in fixture
      # we write this
      author = Author.first

      # Act
      @book.author = author

      # Assert
      @book.author_id.must_equal author.id
    end

    # genres
    it "connects genres and genre_ids" do
      # Arrange
      # genre = Genre.create!(name: 'test genre')
      genre = Genre.first

      # Act
      @book.genres << genre

      # Assert
      @book.genre_ids.must_include genre.id
      # you can also write @book.genres.must_include genre
      # but the code being displayed is better

    end

  end


end
