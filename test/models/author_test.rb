require "test_helper"

describe Author do

  describe "relations" do
    before do
      @author = Author.new(name: "test author")
    end

    it "connects books and book_ids" do
      book = Book.first

      @author.books << book

      @author.book_ids.must_include book.id
    end
  end

end
