class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def sample_email(user)
    @user = user
    
    puts @user
    mail(to: @user.email, subject: 'Sample Email')
  end

end
