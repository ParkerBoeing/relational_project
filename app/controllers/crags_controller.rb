class CragsController < ApplicationController
  def index
   @crags = Crags.all
  end
end