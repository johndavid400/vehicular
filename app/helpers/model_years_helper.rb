module ModelYearsHelper

  def get_sample_image_for_style(style)
    Edmunds::Photo.new.find_sample_by_style_id(style)
  end

  def get_sample_image_for_model_year(year)
    style = year["styles"].first["id"]
    Edmunds::Photo.new.find_sample_by_style_id(style)
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
    style = model["subModels"][condition].first["styleIds"].first
    Edmunds::Photo.new.find_sample_by_style_id(style)
  end

  def get_image(urls)
    "http://media.ed.edmunds-media.com" + urls.select{|s| s.match(/\d{3}(.jpg)/) }.max
  end

end
