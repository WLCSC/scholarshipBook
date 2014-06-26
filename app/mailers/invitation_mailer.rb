class InvitationMailer < ActionMailer::Base
  default from: "noreply@wl.k12.in.us"

  def send_invitation(datum, token, address)
    @datum = datum
    @scholarship = @datum.field.section.scholarship
    @applicant = @datum.application.applicant
    @token = token
    @url = 'http://apps-development:8300/token/' + @token

    mail(to: address, subject: "Scholarship Recommendation Request")
  end
end
