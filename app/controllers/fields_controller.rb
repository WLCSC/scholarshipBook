class FieldsController < ApplicationController
  before_action :set_field, only: [:show, :edit, :update, :destroy]
  before_action :set_scholarship
  before_action :check_for_admin

  # GET /fields
  # GET /fields.json
  def index
    @fields = Field.all
  end

  # GET /fields/1
  # GET /fields/1.json
  def show
  end

  # GET /fields/new
  def new
    @field = @section.fields.build
  end

  # GET /fields/1/edit
  def edit
  end

  # POST /fields
  # POST /fields.json
  def create
    @field = @section.fields.build(field_params)

    respond_to do |format|
      if @field.save
        format.html { redirect_to scholarship_sections_path(@scholarship), notice: 'Field was successfully created.' }
        format.json { render :show, status: :created, location: @field }
      else
        format.html { render :new }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fields/1
  # PATCH/PUT /fields/1.json
  def update
    respond_to do |format|
      if @field.update(field_params)
        format.html { redirect_to scholarship_section_path(@scholarship), notice: 'Field was successfully updated.' }
        format.json { render :show, status: :ok, location: @field }
      else
        format.html { render :edit }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fields/1
  # DELETE /fields/1.json
  def destroy
    @field.destroy
    respond_to do |format|
      format.html { redirect_to scholarship_section_path(@scholarship), notice: 'Field was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_field
      @field = Field.find(params[:id])
    end

    def set_scholarship
        @scholarship = Scholarship.find(params[:scholarship_id])
        @section = Section.find(params[:section_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def field_params
      params.require(:field).permit(:section_id, :title, :caption, :kind, :config, :completed_by)
    end
end
