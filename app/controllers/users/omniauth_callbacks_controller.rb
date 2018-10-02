class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    login_omniauth(request.env["omniauth.auth"])
  end

  def google_oauth2
    login_omniauth(request.env["omniauth.auth"])
  end

  def failure
    redirect_to root_path
  end

  private
    def login_omniauth(omniauth_info)
      @user = User.from_omniauth(omniauth_info)

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: omniauth_info.provider.capitalize) if
          is_navigational_format?
      else
        session["devise.#{omniauth_info.provider}_data"] = omniauth_info
        redirect_to new_user_registration_url
      end
    end

end