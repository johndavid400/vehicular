class HomeController < ApplicationController

  def index
    @types = ["NEW", "USED", "ALL"]
  end

end
