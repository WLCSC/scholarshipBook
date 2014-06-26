class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_scholarship
  before_action :check_for_judge

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = @scholarship.reviews.where(:judge_id => current_judge.id)
    @started_ids = @reviews.map{|r| r.application.id}
    @applications = @scholarship.applications.where.not(:id => @started_ids)
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
      @application = @review.application
      @scores = []
      @scholarship.sections.each do |s|
          @scores << @review.scores.where(:section_id => s.id).first_or_create(:status => 0)
      end
      if Scholarship.where(:global => true).count > 0
          @global = true
          @global_applications = @application.applicant.applications.to_a.keep_if{|a| a.scholarship.global}
      else
          @global = false
      end
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.judge = current_judge
    @review.status = 0
    respond_to do |format|
      if @review.save
        format.html { redirect_to [@scholarship, @review], notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to scholarship_reviews_path(@scholarship), notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to scholarship_reviews_url(@scholarship), notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def set_scholarship
        @scholarship = Scholarship.find(params[:scholarship_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:notes, :judge_id, :application_id, :status)
    end
end
