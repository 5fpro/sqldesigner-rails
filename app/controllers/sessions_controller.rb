class SessionsController < ApplicationController

  def create
    if current_user = User.create_by_omniauth(request.env['omniauth.auth'], current_user)
       # flash[:notice] = "Login ok!"
       # send("auth_by_#{params[:provider]}") rescue nil
       sign_in_and_redirect :user, current_user
    else
      raise do
        logger.info "request.env['omniauth.auth']: #{request.env['omniauth.auth'].inspect}"
      end
    end  
  end

  def failure
    flash[:error] = params[:message]
    redirect_to new_user_session_path
  end

  private
  
  # def auth_by_facebook
  #   current_user.facebook_token.value = request.env['omniauth.auth'].credentials.token
  # end

end
