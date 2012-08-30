class UserMailer < ActionMailer::Base
  default from: "no-reply@theshoplift.com"

  def todon
    @greeting = "Hi"

    mail to: "dondenoncourt@gmail.com",
        subject: "test",
        from: "dondenoncourt@comcast.net"

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    mail to: @user.email, from: "welcome@theshoplift.com"
  end

  def follower_notification(user, follower)
    @user = user
    @follower = follower
    mail to: user.email,
         subject: "[The Shoplift] You have a new follower!",
         content_type: "text/html"
  end

  def share(current_user, item, to, subject, thoughts)
    puts "thoughts:"+thoughts
    @item = item
    @comment = thoughts # for some reason @thoughts does  not work
    mail to: to,
         subject: subject,
         content_type: "text/html",
         reply_to: current_user.email
  end
end
