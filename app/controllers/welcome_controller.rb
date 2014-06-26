class WelcomeController < ApplicationController
  def index
      @scholarships = Scholarship.where(:active => true)
  end
end
