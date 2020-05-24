class ThanksMailer < ApplicationMailer
  def send_mail_when_sign_up(user)
  	  @user = user
  	  @url = 'http://localhost:3000/users/#{user.id}'
  	  mail to: user.email, 
  	       subject: "[bookers]新規登録が完了しました！"
  end
end
