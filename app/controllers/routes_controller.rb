class RoutesController < ApplicationController
  def index
   @routes = Route.bolted_routes
  end

  def show
    @route = Route.find(params[:id])
  end

  def edit
    @route = Route.find(params[:id])
  end

  def update
    route = Route.find(params[:id])
    route.update({
      name: params[:route][:name],
      meters_tall: params[:route][:meters_tall],
      bolted: params[:route][:bolted]
    })
    route.save
    redirect_to "/routes/#{route.id}"
  end

  def destroy
    route = Route.find(params[:id])
    route.destroy
    redirect_to "/routes"
  end
end