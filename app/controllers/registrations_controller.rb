class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
  end

  def update
    super
  end

  private

  def after_sign_up_path_for(resource)
    page_follow_interests_path
  end
end 


