class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def sample_email(user, article)
    @user = user
    @article = article
    
    puts @user
    mail(to: @user.email, subject: "#{@article.title}")
  end

end
