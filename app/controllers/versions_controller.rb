class VersionsController < ApplicationController


  def show
    @book = Book.find(params[:id])
    @chunk = Chunk.find(params[:id])
  end
end
