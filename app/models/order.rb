class Order < ApplicationRecord
  belongs_to :user

  validates :status, presence: true

  validates :subtotal, :tax_total, :grand_total,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
end
