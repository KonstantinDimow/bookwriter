class VersionsController < ApplicationController
  def show
    @chunk = Chunk.find(params[:id])
  end

  def revert_to_old_version
    @chunk.version(params[:version_id]).reify.save!
  end
end
