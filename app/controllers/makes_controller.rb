class MakesController < ApplicationController

  def index
    if params[:type] == "ALL"
      @makes = Edmunds::Make.new.find_all
    elsif params[:type] == "USED"
      @makes = Edmunds::Make.new.find_used_makes
    else
      @makes = Edmunds::Make.new.find_new_makes
    end
  end

  def show
    @make = params[:name]
    @models = Edmunds::Model.new.find_by_make_id(params[:id])
  end

end
