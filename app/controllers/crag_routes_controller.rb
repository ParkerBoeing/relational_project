class CragRoutesController < ApplicationController
  def index
    @crag = Crag.find(params[:crag_id])
    @routes = @crag.routes
  end
end