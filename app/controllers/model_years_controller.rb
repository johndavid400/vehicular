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
    @model_id = @styles.first["modelId"]
    @make_id = @styles.first["makeId"]
    @year = @styles.first["year"]
    @make = @styles.first["makeName"]
    @model = @styles.first["modelName"]
  end

  def details
    @style_id = params[:id]
    @style = Edmunds::Style.new.find_by_id(@style_id)
    @engine = Edmunds::Equipment.new.find_engines_by_style_id(@style_id)
    @model_id = @style.first["modelId"]
    @make_id = @style.first["makeId"]
    @year = @style.first["year"]
    @make = @style.first["makeName"]
    @model = @style.first["modelName"]
    @model_year_id = @style.first["modelYearId"]
    @style_name = @style.first["attributeGroups"]["MAIN"]["attributes"]["NAME"]["value"]
    @images = Edmunds::Photo.new.find_by_style_id(@style_id)
  end

end
