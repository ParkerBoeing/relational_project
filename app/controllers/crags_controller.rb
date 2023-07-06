class CragsController < ApplicationController
  def index
   @crags = Crag.all
  end

  def show
    
  end
end