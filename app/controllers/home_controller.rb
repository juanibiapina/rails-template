class HomeController < ApplicationController
  before_action :authenticate_account!

  def index
    # Simple landing page for authenticated users
  end
end
