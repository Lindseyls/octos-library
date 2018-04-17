class SessionsController < ApplicationController

  def new
    @author = Author.new
  end

  def create
    author = Author.find_by(name: params[:author][:name])


    if author
      session[:author_id] = author.id
      # more full proof to use id's rather than
      # names. Also less memory to store integers
      flash[:success] = "#{ author.name } is successfully logged in."
      redirect_to root_path
      # this is for authors that already exist
    else
      # use an else statement for other logic that does more stuff
    end
  end

  def destroy
    # session[:author_id] = nil
    # you can write it as above OR the below with .delete
    session.delete(:author_id)
    flash[:success] = "Logged out successfully"

    redirect_to root_path
  end

end
