class CragsController < ApplicationController
  def index
   @crags = Crag.all.order("created_at DESC")
  end

  def show
    @crag = Crag.find(params[:id])
  end

  def new
  end

  def crag_params
    params.permit(:name)
    params.permit(:elevation)
    params.permit(:nearby_camping)
  end

  def create
    crag = Crag.new(crag_params)
    crag.save
    redirect_to "/crags"
  end

  def edit
    @crag = Crag.find(params[:id])
  end

  def update
    crag = Crag.find(params[:id])
    crag.update({
      name: params[:crag][:name],
      elevation: params[:crag][:elevation],
      nearby_camping: params[:crag][:nearby_camping]
    })
    crag.save
    redirect_to "/crags/#{crag.id}"
  end

  def destroy
    crag = Crag.find(params[:id])
    crag.destroy
    redirect_to "/crags"
  end
end