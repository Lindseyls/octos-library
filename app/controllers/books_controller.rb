class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]


  def index
    # Placeholder book data until we get models tomorrow!
    # @my_string = "yelling"
    if params[:author_id]
      # Have an author id
      @books = Author.find(params[:author_id]).books
      @books = @author.books
      # - or -
      # @books = Book.where(author_id: params[:author_id])
    else
      # No author, load all the book
      # This is our old, non-rested version
      @books = Book.all
    end
  end

  def new
    @book = Book.new(author_id: params[:author_id])
  end

  def create
    # Rails form_for creates a nested param structure
    # This is fancy and good, but means we need to do
    # a little extra work.

    # # Or could do
    # raw_book = params[:book]
    #
    # book = Book.new
    #
    # book.title = raw_book[:title]
    # book.author = raw_book[:author]
    # book.publication_date = raw_book[:publication_date]
    # book.synopsis = raw_book[:synopsis]


    # # Could also say:
    # book.title = params[:book][:title]
    # Originally is said:
    # book = Book.new(title: params[:my_title], author: params[:author])

    # # This is the final way that we want to see using the private method
    @book = Book.new(book_params)

    if @book.save
      flash[:success] = "Book added successfully"
      # can write the below also as
      # redirect_to '/books'
      redirect_to books_path
    else
      flash.now[:failure] = "Validations Failed"
      # Validations failed! What do we do now? See below...
      render :new, status: :bad_request
    end

  end

  # def show
  #   # # Figure out which book the user wanted
  #   # book_id = params[:id]
  #   #
  #   # # Load it from the DB
  #   # # Save it in an instance variable for the view
  #   # @book = Book.find(book_id)
  #   #
  #   # # ####you can combine the above two line of code
  #   # # into the below
  #   # # @book = Book.find_by_id(params[:id])
  # end

  # **** The above show method can now be modified to
  # the below line of method because of the before_action
  def show; end

  # def edit
  #   @book = Book.find(params[:id])
  # end

  # *** The below method is using the above_action
  def edit; end

  def update
    # raw_book = params[:book]

    # **** the below line of code is not needed now after
    # we added the before_action with controller filters
    # @book = Book.find(params[:id])

    # We could follow the same pattern from the create method
    # book.title = raw_book[:title]
    # book.author = raw_book[:author]
    # book.publication_date = raw_book[:publication_date]
    # book.synopsis = raw_book[:synopsis]

    # Or we can do it all together with assign_attributes
    # book.assign_attributes(
    #   title: raw_book[:title],
    #   author: raw_book[:author],
    #   publication_date: raw_book[:publication_date],
    #   synopsis: raw_book[:synopsis]
    # )

    # ORRRR we can do the below
    # this is what we want to see using private method to DRY up code
    @book.assign_attributes(book_params)

    # Arbitrary rule: always use update_attributes, not
    # update, This will pay off later.

    if @book.save
      redirect_to book_path(@book)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    # find it first
    # check the result of destroy

    # Book.destroy(params[:id])

    @book.destroy

    redirect_to books_path
  end

  private

  def book_params
    return params.require(:book).permit(:title, :author_id, :synopsis, :publication_year, genre_ids: [])
  end

  def find_book
    @book = Book.find_by_id(params[:id])
    # *** or do @book = Book.find_by(id: params[:id])
    # use find_by(id:) instead of find
    head :not_found unless @book
    # @book will be nil if the find_by failed
    # head is simialr  to render, except it doesn't run
    #   a view template, so the browser only gets the status code
    # This is not the only thing you can do in this scenaria
    #   but it is the simplest
  end
end
