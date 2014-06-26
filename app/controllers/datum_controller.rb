class DatumController < ApplicationController
    before_filter :check_for_user
  def update
      id = params[:id]
      match = id.match /sfid-f(\d+)-d(\d+)/
      @field = Field.find(match[1])
      @datum = Datum.find(match[2])
      if @datum.field == @field
          @datum.value = params[:value]
          @datum.status = 100
          if @datum.save
              @datum.application.save
              if params[:invitation_id]
                  invite = Invitation.find(params[:invitation_id])
                  invite.complete = true
                  invite.save
              end
              render :json => {status: "OK"}
          else
              render :json => @datum.errors, :status => 400
          end
      else
          render :json => {:error => 'Field/datum conflict.'}, :status => 400
      end
  end
end
