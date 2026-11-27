class Province < ApplicationRecord
  has_many :users

  validates :name, presence: true,
                   uniqueness: true

  validates :gst_rate, :pst_rate, :hst_rate,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
end
