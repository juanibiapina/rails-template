class User < ApplicationRecord
  has_one :account, dependent: :destroy

  validates :name, presence: true
end
