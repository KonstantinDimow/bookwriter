class VersionsController < ApplicationController
  def show
    @chunk = Chunk.find(params[:chunk_id])
    @book = Book.find(params[:book_id])
  end

  def compare_version

  end

  def version

       @version = Version.find(params[:version_id])
  end
end
