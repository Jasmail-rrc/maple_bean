
# Maple Bean Coffee Shop - Sample Products

products = [
  {
    name: "Maple House Blend Coffee Beans",
    description: "Medium roast coffee beans with smooth chocolate and caramel notes. Perfect for everyday brewing.",
    price: 18.99,
    stock_quantity: 50
  },
  {
    name: "Dark Roast Espresso Beans",
    description: "Rich dark roast coffee beans with bold flavour and a smooth finish. Ideal for espresso lovers.",
    price: 21.99,
    stock_quantity: 40
  },
  {
    name: "Colombian Arabica Coffee Beans",
    description: "Premium Colombian Arabica beans with balanced acidity and sweet nutty flavours.",
    price: 22.99,
    stock_quantity: 35
  },
  {
    name: "Classic Ground Coffee",
    description: "Freshly ground medium roast coffee with a smooth taste, perfect for drip coffee makers.",
    price: 16.99,
    stock_quantity: 60
  },
  {
    name: "French Vanilla Ground Coffee",
    description: "Aromatic ground coffee with a sweet French vanilla flavour and a creamy finish.",
    price: 17.99,
    stock_quantity: 45
  },
  {
    name: "Hazelnut Ground Coffee",
    description: "Smooth ground coffee infused with a delicious roasted hazelnut flavour.",
    price: 17.49,
    stock_quantity: 40
  },
  {
    name: "Maple Bean Ceramic Mug",
    description: "A durable ceramic coffee mug with a comfortable handle, perfect for your morning coffee.",
    price: 12.99,
    stock_quantity: 30
  },
  {
    name: "Insulated Travel Coffee Mug",
    description: "Stainless steel insulated travel mug designed to keep your coffee hot while travelling.",
    price: 24.99,
    stock_quantity: 25
  },
  {
    name: "French Press Coffee Maker",
    description: "A classic French press coffee maker that produces rich and flavourful coffee.",
    price: 34.99,
    stock_quantity: 20
  },
  {
    name: "Reusable Coffee Filter",
    description: "An environmentally friendly reusable coffee filter suitable for everyday brewing.",
    price: 9.99,
    stock_quantity: 50
  }
]

products.each do |product|
  Product.find_or_create_by!(name: product[:name]) do |record|
    record.description = product[:description]
    record.price = product[:price]
    record.stock_quantity = product[:stock_quantity]
  end
end

puts "Coffee shop products seeded successfully!"

# Create product categories
category_names = [
  "Coffee Beans",
  "Ground Coffee",
  "Coffee Mugs",
  "Brewing Accessories"
]

category_names.each do |name|
  Category.find_or_create_by!(name: name)
end

# Assign products to categories
category_products = {
  "Coffee Beans" => [
    "Maple House Blend Coffee Beans",
    "Dark Roast Espresso Beans",
    "Colombian Arabica Coffee Beans"
  ],
  "Ground Coffee" => [
    "Classic Ground Coffee",
    "French Vanilla Ground Coffee",
    "Hazelnut Ground Coffee"
  ],
  "Coffee Mugs" => [
    "Maple Bean Ceramic Mug",
    "Insulated Travel Coffee Mug"
  ],
  "Brewing Accessories" => [
    "French Press Coffee Maker",
    "Reusable Coffee Filter"
  ]
}

category_products.each do |category_name, product_names|
  category = Category.find_by!(name: category_name)

  product_names.each do |product_name|
    product = Product.find_by!(name: product_name)
    product.categories << category unless product.categories.include?(category)
  end
end

puts "Product categories created and assigned successfully!"
