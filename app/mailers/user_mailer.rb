class UserMailer < ApplicationMailer
  def order_mail user, order
    @user = user
    @order = order
    mail to: user.email, subject: I18n.t("order_mailer.subject")
  end

  def cancel_order current_user, order
    @user = current_user
    @order = order
    mail to: @user.email, subject: I18n.t("order_mailer.subject")
  end
end
