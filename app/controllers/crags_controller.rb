class CragsController < ApplicationController
  def index
   @crags = Crag.all
  end

  def show
    @crag = Crag.find(params[:id])
  end
end