class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to @list
    else
      render "lists/show", status: :unprocessable_entity
    end
  end

  def destroy
    # Find the bookmark
    @bookmark = Bookmark.find(params[:id])
    # Find the parent list
    @list = @bookmark.list
    # Delete the bookmark
    @bookmark.destroy
    # Redirect to the list
    redirect_to @list
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
