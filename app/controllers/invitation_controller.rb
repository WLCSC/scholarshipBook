class InvitationController < ApplicationController
    before_action :check_for_applicant, only: [:generate]
    before_action :check_for_recommender, except: [:generate, :apply]
    def generate
        @datum = Datum.find(params[:datum_id])
        @invite = @datum.create_invitation()
        @token = User.generate_token_for(:rec, @datum.id, params[:email])

        InvitationMailer.send_invitation(@datum.id, @token, params[:email]).deliver!
        render :js=> 'alert("Invitation has been sent!");'
    end

    def apply
        @token = params[:token]
        begin
        @datum = Datum.find(User.extract_token_id(@token, :rec))
        if params[:name]
            @user = User.new(:name => params[:name], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
            unless @user.save
                flash[:error] = @user.errors.full_messages.join(', ')
                redirect_to root_path
                return
            end
            @user.promote_recommender
            session[:user_id] = @user.id
        end
        if current_user
        if User.verify_token_for(@token, :rec, @datum.id, current_user.email, 1.week.ago)
            current_user.promote_recommender if current_user && !current_recommender
            if current_recommender
                @datum.invitation.recommender = current_recommender
                @datum.invitation.save
                redirect_to invitation_submit_path(:invitation_id => @datum.invitation.id) 
            else
                session[:token] = @token
            end
        else
            logger.info "Verify returned false."
            redirect_to root_path, :alert => 'Invalid invitation token.'
        end
        end

        rescue => ex
            logger.fatal "Verify threw exception #{ex.to_s}"
            redirect_to root_path, :alert => 'Invalid invitation token.'
        end
    end

    def index
        if current_admin
            @invitations = Invitation.all
        else
            @invitations = current_recommender.invitations.where(:complete => nil)
        end
    end

    def submit
        @invitation = Invitation.find(params[:invitation_id])
        if @invitation.recommender != current_recommender
            redirect_to invitations_path, :error => "That's not your recommendation!"
            return
        end
        if @invitation.complete
            redirect_to invitations_path, :error => 'You already completed that recommendation.'
            return
        end
        if params[:commit] == "Submit Recommendation"
            @invitation.complete = true
            @invitation.save
            redirect_to invitations_path
        else
            @datum = @invitation.datum
            @field = @datum.field
            @applicant = @datum.application.applicant
        end
    end
end
