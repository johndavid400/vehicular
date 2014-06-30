module ModelYearsHelper

  def get_sample_image_for_style(style)
    get_image(style)
  end

  def get_sample_image_for_model(model)
    if model["publicationStates"].include?("NEW")
      condition = "NEW"
    elsif model["publicationStates"].include?("PRE_PROD")
      condition = "PRE_PROD"
    elsif model["publicationStates"].include?("NEW_USED")
      condition = "NEW_USED"
    else
      condition = "USED"
    end
    style = model["subModels"][condition].first["styleIds"]
    get_image(style)
  rescue
    style = model["subModels"].first.last.first["styleIds"]
    get_image(style)
  end

  def get_image(style)
    image = Edmunds::Photo.new.find_sample_by_style_id(style)
    image.match(/http/)
    image
  rescue
    "/no-image.jpg"
  end

  def find_best_image(urls)
    "http://media.ed.edmunds-media.com" + urls.select{|s| s.match(/\d{3}(.jpg)/) }.max
  end

  def style_name(style)
    "#{style["attributeGroups"]["STYLE_INFO"]["attributes"]["STANDARD_VEHICLE_DESCRIPTION"]["value"]} #{horsepower(style)} #{mpg(style)}"
  end

  def mpg(style)
    attributes = style["attributeGroups"]["SPECIFICATIONS"]["attributes"]
    "- #{attributes["EPA_CITY_MPG"]["value"]}/#{attributes["EPA_HIGHWAY_MPG"]["value"]} mpg"
  rescue
    ""
  end

  def horsepower(style)
    engine_specs = Edmunds::Equipment.new.find_engines_by_style_id(style["id"])
    "#{engine_specs.first.last["attributeGroups"]["ENGINE"]["attributes"]["HORSEPOWER"]["value"]}HP"
  rescue
    ""
  end

  def engine_highlights(engine)
    stats = engine.first.last["attributeGroups"]["ENGINE"]["attributes"]
    engine_stats = "#{stats["SIZE"]["value"]}L #{stats["HORSEPOWER"]["value"]}HP #{stats["ENGINE_CONFIGURATION"]["value"]} #{stats["CYLINDER"]["value"]}"
    "Engine Highlights: #{engine_stats}"
  rescue
    ""
  end

end
