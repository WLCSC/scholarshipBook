class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :destroy, :promote]
    before_action :check_for_admin, except: [:show, :edit, :update, :new, :create]

    # GET /users
    # GET /users.json
    def index
        @users = User.all
    end

    # GET /users/1
    # GET /users/1.json
    def show
        @user = User.find(params[:id] || current_user.id)
        check_for_admin_or_user @user
    end

    # GET /users/new
    def new
        @user = User.new
    end

    # GET /users/1/edit
    def edit
        check_for_admin_or_user @user
    end

    # POST /users
    # POST /users.json
    def create
        @user = User.new(user_params)
        if current_user && !current_admin
            redirect_to root_path, :notice => "You have to be an admin to do that."
        else
            respond_to do |format|
                if @user.save
                    if @user == User.first
                        @user.promote_admin if @user == User.first
                    else
                        if params[:recommender]
                            @user.promote_recommender
                        else
                            @user.promote_applicant
                        end
                    end
                    session[:user_id] = @user.id unless current_user 
                    format.html { redirect_to @user, notice: 'User was successfully created.' }
                    format.json { render :show, status: :created, location: @user }
                else
                    format.html { render :new }
                    format.json { render json: @user.errors, status: :unprocessable_entity }
                end
            end
        end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
        check_for_admin_or_user @user
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to @user, notice: 'User was successfully updated.' }
                format.json { render :show, status: :ok, location: @user }
            else
                format.html { render :edit }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
        @user.destroy
        respond_to do |format|
            format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    def promote
        check_for_admin
        role = params[:role]
        case role
        when 'Admin'
            @user.promote_admin
        when 'Judge'
            @user.promote_judge
        when 'Applicant'
            @user.promote_applicant
        when 'Recommender'
            @user.promote_recommender
        end
        redirect_to @user
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        params.require(:user).permit(:email, :name, :password)
    end
end
