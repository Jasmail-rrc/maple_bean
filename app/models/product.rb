class Product < ApplicationRecord
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

validates :name, presence: true,
                 length: { minimum: 3, maximum: 100 }

validates :description, presence: true

validates :price, presence: true,
                  numericality: { greater_than: 0 }

validates :stock_quantity, presence: true,
                           numericality: {
                             only_integer: true,
                             greater_than_or_equal_to: 0
                           }
end
