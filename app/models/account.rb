class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [ :google ]

  belongs_to :user

  attr_accessor :name

  before_validation :create_user_if_needed, on: :create

  def self.from_omniauth(auth)
    account = where(email: auth.info.email).first

    if account
      # Update existing account with OAuth data
      account.update(
        provider: auth.provider,
        uid: auth.uid
      )
      account.user.update(
        name: auth.info.name,
        picture: auth.info.image
      )
    else
      # Create new user and account
      user = User.create!(
        name: auth.info.name,
        picture: auth.info.image
      )
      account = create!(
        user: user,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
        provider: auth.provider,
        uid: auth.uid
      )
    end
    account
  end

  private

  def create_user_if_needed
    return if user.present? # Skip if user is already assigned (e.g., OAuth)

    # Since name is required, we expect it to be present
    self.user = User.create!(name: name)
  end
end
