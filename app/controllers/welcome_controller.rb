class WelcomeController < ApplicationController
  def index
      @scholarships = Scholarship.where(:active => true)
      @messages = Message.all
  end
end
