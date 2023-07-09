class CragsController < ApplicationController
  def index
   @crags = Crag.all.order("created_at DESC")
  end

  def show
    @crag = Crag.find(params[:id])
  end

  def new
  end

  def create
    crag = Crag.new({
      name: params[:crag][:name],
      meters_tall: params[:crag][:meters_tall],
      nearby_camping: params[:crag][:nearby_camping]
    })

    crag.save

    redirect_to "/crags"
  end
end