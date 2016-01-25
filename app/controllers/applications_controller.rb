class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy, :review]
  before_action :set_user
  before_action :check_for_applicant_or_admin, except: [:show, :update, :review]

  # GET /applications
  # GET /applications.json
  def index
    @applications = @user.applications
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
      redirect_to scholarships_path if @application.status >= 100 && !current_admin
      if current_admin
        @statusList = {"Incomplete" => 0, "Complete" => 100, "Discard" => 400}
      else
        @statusList = {"Incomplete" => 0, "Continue to Review" => 90}
      end
  end

  def review 
      @statusList = {"Go Back" => 0, "Complete" => 100}
  end

  # GET /applications/new
  def new
    @scholarship = Scholarship.find(params[:scholarship_id])
    if @application = Application.where(:applicant_id => @user.applicant.id, :scholarship_id => @scholarship.id)
        redirect_to [@user, @application]
    else
    if @scholarship && @scholarship.active
        @application = Application.create(:applicant_id => @user.applicant.id, :scholarship_id => @scholarship.id, :status => 0)
        @scholarship.fields.each do |f|
            @application.data.create(:field_id => f.id, :status => 0)
        end
        redirect_to [@user, @application]
    else
        redirect_to scholarships_path, :notice => 'That is not an active scholarship.'
    end
    end
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = @user.applications.build(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to [@user, @application], notice: 'Application was successfully created.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
          if @application.status == 100
             @application.first_party_data.each do |d|
                 d.status = 100
                 d.save
             end
             target = scholarships_path
          elsif @application.status == 90
             @application.first_party_data.each do |d|
                 d.status = 100
                 d.save
             end
              target = review_user_application_path(@user, @application)
          else
              target = [@user, @application]
          end
        format.html { redirect_to target, notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to user_applications_url(@user), notice: 'Application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    def set_user
        @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:applicant_id, :scholarship_id, :status)
    end
end
