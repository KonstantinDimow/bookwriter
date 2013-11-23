class VersionsController < ApplicationController
  def show
    @chunk = Chunk.find(params[:chunk_id])
  end
end
