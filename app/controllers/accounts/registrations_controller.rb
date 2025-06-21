class Accounts::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
  end

  def build_resource(hash = {})
    super(hash)
    if params[:account] && params[:account][:name].present?
      resource.name = params[:account][:name]
    end
  end
end
