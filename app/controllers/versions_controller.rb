class VersionsController < ApplicationController
  def show
    @chunk = Chunk.find(params[:id])
    @book = Book.find(@chunk.book_id)
  end

  def revert_to_old_version
    #@chunk.versions(params[:old_version_id]).reify.save!
    @chunk = Chunk.find(params[:id])
    @chunk.versions[params[:old_version_id].to_i].reify.save!
    redirect_to  edit_book_chunk_path
  end

  def version
    @book = Book.find(params[:book_id])
    @chunk = Chunk.find(params[:chunk_id])
    @version = Version.find(params[:version_id])
  end
end
