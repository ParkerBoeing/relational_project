class CragRoutesController < ApplicationController
  def index
    @crag = Crag.find(params[:crag_id])
    @routes = if params[:sort] == "name"
                @crag.routes.alphabetize
              else
                @crag.routes
              end
    if params[:threshold].present?
      @routes = @routes.where("meters_tall > ?", params[:threshold].to_i)
    end
  end

  def new
    @crag = Crag.find(params[:crag_id])
    @routes = @crag.routes
  end

  def create
    @crag = Crag.find(params[:crag_id])
    route = @crag.routes.create!({
      name: params[:route][:name],
      meters_tall: params[:route][:meters_tall],
      bolted: params[:route][:bolted]
    })
    route.save
    redirect_to "/crags/#{@crag.id}/routes"
  end
end