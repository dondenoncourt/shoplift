class RegistrationsController < Devise::RegistrationsController

  private

  def after_sign_up_path_for(resource)
    shoplifters_path
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end


