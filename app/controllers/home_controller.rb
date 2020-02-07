class HomeController < ApplicationController
  skip_before_action :require_read_access

  def index
  end
end
