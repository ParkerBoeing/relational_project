class CragRoutesController < ApplicationController
  def index
    @crag = Crag.find(params[:crag_id])
    @routes = @crag.routes
  end

  def new
  end

  def create
    route = crag.routes.create!({
      name: params[:route][:name],
      meters_tall: params[:route][:meters_tall],
      bolted: params[:route][:bolted]
    })
    route.save
    redirect_to "/crags/#{@crag.id}/routes"
  end
end