class HomeController < ApplicationController
  layout 'public'
  def index
    @books = Book.includes(:category).order(:title)
  end
end