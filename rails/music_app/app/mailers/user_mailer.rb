class UserMailer < ApplicationMailer
  def activate_email(user)
    @user = user
    @url = "http://localhost:3000/users/activate?activation_token=#{ @user.activation_token }"

    mail(to: user.email, subject: "Activate your account now!")
  end

  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000/session/new"

    mail(to: user.email, subject: "Welcome to Music APP!!")
  end
end
