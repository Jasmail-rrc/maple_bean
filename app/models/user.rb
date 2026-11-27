class User < ApplicationRecord
  belongs_to :province
  has_many :orders

  validates :name, presence: true

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password_digest, presence: true

  validates :address, :city, :postal_code,
            presence: true
end
