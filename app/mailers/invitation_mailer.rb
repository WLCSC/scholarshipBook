class InvitationMailer < ActionMailer::Base
    include Resque::Mailer
  default from: "noreply@wl.k12.in.us"

  def send_invitation(datum, token, address)
    @datum = Datum.find(datum)
    @scholarship = @datum.field.section.scholarship
    @applicant = @datum.application.applicant
    @token = token
    @url = 'https://apps.wl.k12.in.us/scholarships/token/' + @token

    mail(to: address, subject: "WLHS Scholarship Recommendation Request").deliver
  end
end
