class Accounts::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def google
    @account = Account.from_omniauth(request.env["omniauth.auth"])

    if @account.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Google"
      sign_in_and_redirect @account, event: :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except("extra") # Removing extra as it can overflow some session stores
      redirect_to new_account_registration_url, alert: @account.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to root_path
  end
end
