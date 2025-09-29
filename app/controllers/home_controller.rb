class HomeController < ApplicationController
  def index
    @books = Book.includes(:category).order(:title)
  end
end