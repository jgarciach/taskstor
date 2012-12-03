class RegistrationsController < Devise::RegistrationsController
 protected

  def after_inactive_sign_up_path_for(users)
    static_confirmation_path
  end

end
