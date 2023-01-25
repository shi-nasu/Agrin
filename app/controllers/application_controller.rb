class ApplicationController < ActionController::Base
  #↓新規登録する際に入力項目を増やすために必要な記述↓

  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログアウトの際、adminのログインページに遷移する記述
  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    elsif resource == :customer #　ログアウトの際、customerのtopページに遷移する記述
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end
end
