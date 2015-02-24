class ScoreController < ApplicationController
    before_action :check_for_judge
  def update
      id = params[:id]
      match = id.match /rid-s(\d+)-a(\d+)-(\w)/
      @score = Score.find(match[1])
      @application = Application.find(match[2])
      field = match[3]
      if @score.review.application == @application
          puts "!!!" + field
          case field
          when 'n'
              @score.notes = params[:value]
          when 's'
              @score.score = params[:value].to_i
          when 'u'
              @score.status = params[:value].to_i
          end
          if @score.save
              @application.save
              render :json => {status: "OK"}
          else
              render :json => @score.errors, :status => 400
          end
      else
          render :json => {:error => 'Score/Application conflict.'}, :status => 400
      end
  end
end
