class MakesController < ApplicationController

  def index
    @makes = Edmunds::Make.new.find_all
  end

  def show
    @make = params[:name]
    @models = Edmunds::Model.new.find_by_make_id(params[:id])
  end

end
