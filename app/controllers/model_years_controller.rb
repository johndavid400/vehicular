class ModelYearsController < ApplicationController

  def index
    @make = params["make"]
    @model = params["model"]
    if session[:condition] == "ALL"
      @model_years = Edmunds::ModelYear.new.for_model_id(params[:id])
    elsif session[:condition] == "USED"
      @model_years = Edmunds::ModelYear.new.find_used_model_years_by_model_id(params[:id])
    else
      @model_years = Edmunds::ModelYear.new.find_new_model_years_by_model_id(params[:id])
    end
  end

  def show
    @styles = Edmunds::Style.new.find_styles_by_model_year_id(params[:id])
    @name = "#{@styles.first["year"]} #{@styles.first["makeName"]} #{@styles.first["modelName"]}"
  end

  def details
    style_id = params[:id]
    @style = Edmunds::Style.new.find_by_id(style_id)
    @images = Edmunds::Photo.new.find_by_style_id(style_id)
  end

end
