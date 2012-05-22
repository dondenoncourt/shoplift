class UserMailer < ActionMailer::Base
  default from: "dondenoncourt@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.todon.subject
  #
  def todon
    puts "in todon mailer method"
    @greeting = "Hi"

    mail to: "dondenoncourt@gmail.com",
        subject: "test"
        
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    mail to: @user.email
  end
end
