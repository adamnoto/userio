class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_email.subject
  #
  def welcome_email
    @greeting = "Hi"

    mail to: "to@example.org"

  def reset_password_email(token)
    @password_reset_token = token

    mail to: @password_reset_token.user.email, subject: "Reset password request"
  end
end
