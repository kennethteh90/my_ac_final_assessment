class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def notification(user)
    @user = user
    mail(to: @user.email, subject: 'Another user has liked your note!')
  end

  def unlikenotification(user)
    @user = user
    mail(to: @user.email, subject: 'Oh no! Another user has unliked your note!')
  end

end
