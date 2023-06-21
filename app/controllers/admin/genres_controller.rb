class Admin::GenresController < ApplicationController
  #before_action: autheticate_admin!
  before_action :find_genre, only: [:edit, :update]
  def index
    @genres = Genre.all
    @genre = Genre.new

  end

  def create
    @genres = Genre.all
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      render :index
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private

  def find_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end
