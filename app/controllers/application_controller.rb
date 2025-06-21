class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    head :not_found
  end

  # Override current_user to work with Account-based authentication
  def current_user
    current_account&.user
  end
  helper_method :current_user

  # Override user_signed_in? to work with Account-based authentication
  def user_signed_in?
    account_signed_in?
  end
  helper_method :user_signed_in?
end
