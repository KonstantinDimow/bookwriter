class VersionsController < ApplicationController
  def show
    @chunk = Chunk.find(params[:id])
  end
end
