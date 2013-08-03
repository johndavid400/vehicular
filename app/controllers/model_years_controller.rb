class ModelYearsController < ApplicationController

  def index
    @make = params["make"]
    @model = params["model"]
    @model_years = Edmunds::ModelYear.new.for_model_id(params[:id])
  end

  def show
    binding.pry
  end

end
