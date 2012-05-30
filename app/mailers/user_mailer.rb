class UserMailer < ActionMailer::Base
  default from: "[The Shoplift] <no-reply@theshoplift.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.todon.subject
  #
  def todon
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

  def follower_notification(user, follower)
    @user = user
    @follower = follower
    mail to: user.email,
         subject: "[The Shoplift] You have a new follower!",
         content_type: "text/html"
  end
end
