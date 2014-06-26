class ApplicationController < ActionController::Base
  protect_from_forgery

	#before_filter :check_for_user

  private
  def current_user
	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin
      current_user && current_user.admin? ? current_user.admin : nil
  end

  def current_applicant
      current_user && current_user.applicant? ? current_user.applicant : nil
  end
  
  def current_judge
      current_user && current_user.judge? ? current_user.judge : nil
  end
  
  def current_recommender
      current_user && current_user.recommender? ? current_user.recommender : nil
  end
  
  def check_for_user
    redirect_to root_path, :notice => 'You have to be logged in to do that.' unless current_user
  end
  
  def check_for_admin
    redirect_to root_path, :notice => 'You have to be an admin to do that.' unless current_user && current_user.admin?
  end

  def check_for_applicant
    redirect_to root_path, :notice => 'You have to be an applicant to do that.' unless current_user && current_user.applicant?
  end

  def check_for_applicant_or_admin
    redirect_to root_path, :notice => 'You have to be an applicant to do that.' unless current_user && (current_user.applicant? || current_user.admin?)
  end

  def check_for_admin_or_user u
    redirect_to root_path, :notice => 'You have to be an applicant to do that.' unless current_user && (current_user == u || current_user.admin?)
  end

  def check_for_judge
    redirect_to root_path, :notice => 'You have to be a judge to do that.' unless current_user && current_user.judge?
  end

  def check_for_judge_or_admin
    redirect_to root_path, :notice => 'You have to be a judge to do that.' unless current_user && (current_user.judge? || current_user.admin?)
  end

  def check_for_recommender
    redirect_to root_path, :notice => 'You have to be a recommender to do that.' unless current_user && current_user.recommender?
  end

  helper_method :current_user
  helper_method :current_admin
  helper_method :current_applicant
  helper_method :current_judge
  helper_method :current_recommender
end
