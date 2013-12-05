class VersionsController < ApplicationController
  def show
    @chunk = Chunk.find(params[:chunk_id])
    @book = Book.find(@chunk.book_id)
  end

  def revert_to_old_version
    #@chunk.versions(params[:old_version_id]).reify.save!
    @chunk = Chunk.find(params[:chunk_id])
    @chunk.versions[params[:old_version_id].to_i].reify.save!
    redirect_to  edit_book_chunk_path
  end

  def version
    @book = Book.find(params[:book_id])
    @chunk = Chunk.find(params[:chunk_id])
    @version = Version.find(params[:version_id])
  end

  def compare
    @chunk = Chunk.find(params[:chunk_id])
    if (params[:version1] == 'chunk')
      @version1 = Chunk.find(params[:chunk_id]).content
    else
      @version1 = @chunk.versions[params[:version1].to_i].reify.content
    end
    if (params[:version2]== 'chunk')
      @version2 = Chunk.find(params[:chunk_id]).content
    else
      @version2 = @chunk.versions[params[:version2].to_i].reify.content
    end
  end

end
