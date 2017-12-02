class AuthorizationsController < ApplicationController
  def callback
    user = user_signed_in? ? current_user : nil
    context = UserAuthContext.new(request.env['omniauth.auth'], user)
    if result = context.perform
      sign_in(result[:user])
      redirect_to root_path(host: Setting.host), flash: { success: 'oauth signed in' }
    else
      redirect_to root_path(host: Setting.host), flash: { error: context.error_message }
    end
  end

  def failure
    flash[:error] = params[:message]
    redirect_to root_path(host: Setting.host)
  end

end
