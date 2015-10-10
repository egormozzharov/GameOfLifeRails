class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :ensure_valid_email
  before_action :get_locale_from_db
  before_action :get_locale_from_selector
  before_action :set_theme_from_registered_user
  

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  def ensure_valid_email
    # binding.pry
    # Ensure we don't go into an infinite loop
    return if action_name == 'add_email' || action_name == 'save_email'

    # If the email address was the temporarily assigned one,
    # redirect the user to the 'add_email' page
    if current_user && (!current_user.email || current_user.email == User::TEMP_EMAIL)
      redirect_to add_user_email_path(current_user)
    end
  end

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
      devise_parameter_sanitizer.for(:account_update) << :name
  end


  def get_locale_from_db
    if current_user
      if current_user.locale?
        I18n.locale = current_user.locale
      end
    end
  end


  def get_locale_from_selector
       # binding.pry
    if params[:set_locale]
        # binding.pry
      I18n.locale = params[:set_locale]
      if current_user
          # binding.pry
          current_user.locale = params[:set_locale]
          current_user.save
      end
    end
  end




  def set_theme_from_registered_user
    if params[:theme]
        current_user.theme_color = params[:theme]
        current_user.save
    end
  end



end
