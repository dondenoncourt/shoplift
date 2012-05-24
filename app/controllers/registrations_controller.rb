class RegistrationsController < Devise::RegistrationsController

  private

  def after_sign_up_path_for(resource)
    page_follow_interests_path
  end
end 


