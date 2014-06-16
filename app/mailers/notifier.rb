class Notifier < ActionMailer::Base
  default from: "adrails123@gmail.com"
	def retailer_req(user,token)
		@user = user
		@email = user.email
    @token  = token
    mail(to: @email, subject: 'Retailer Login Approved by admin')
	end
end
