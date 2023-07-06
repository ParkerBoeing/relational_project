class CragsController < ApplicationController
  def index
   @crags = Crag.all
  end
end