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
    "/assets/no-image.jpg"
  end

  def find_best_image(urls)
    "http://media.ed.edmunds-media.com" + urls.select{|s| s.match(/\d{3}(.jpg)/) }.max
  end

end
