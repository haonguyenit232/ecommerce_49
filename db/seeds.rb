User.create! id: 1, name:"admin", role: 1, email: "admin@admin.com", password: "123456"
User.create! id: 2, name:"user", role: 1, email: "user@user.com", password: "123456"
Category.create! id: 1, name: "T-shirt"
Category.create! id: 2, name: "Hoodies"
Category.create! id: 3, name: "Mugs"
Category.create! id: 4, name: "Sneck"
Category.create! id: 6, name: "Leg"
Product.create! id: 1, name: "Black Tees", price: 19, category_id: 1, quantity: 20, description: "Lorem"
Product.create! id: 2, name: "Green Tees", price: 19, category_id: 2, quantity: 20, description: "Lorem"
Product.create! id: 3, name: "Brown Tees", price: 19, category_id: 3, quantity: 20, description: "Lorem"
Product.create! id: 4, name: "Trump Mug", price: 19, category_id: 1, quantity: 20, description: "Lorem"
Product.create! id: 5, name: "Fullprint Leg", price: 19, category_id: 3, quantity: 20, description: "Lorem"
Product.create! id: 6, name: "Christmas Tees", price: 19, category_id: 4, quantity: 20, description: "Lorem"
Order.create! id:1, name: "Order Example", status: "in_progress", user_id: 1
Order.create! id:2, name: "Order Example", status: "in_progress", user_id: 2
Order.create! id:3, name: "Order Example", status: "in_progress", user_id: 2
Order.create! id:4, name: "Order Example", status: "in_progress", user_id: 1
Order.create! id:5, name: "Order Example", status: "in_progress", user_id: 1
Order.create! id:6, name: "Order Example", status: "in_progress", user_id: 1
OrderDetail.create! id:1, quantity: 1, price: 19, product_id: 1, order_id: 1
OrderDetail.create! id:2, quantity: 1, price: 19, product_id: 2, order_id: 2
OrderDetail.create! id:3, quantity: 1, price: 19, product_id: 3, order_id: 3
OrderDetail.create! id:4, quantity: 1, price: 19, product_id: 2, order_id: 1
OrderDetail.create! id:5, quantity: 1, price: 19, product_id: 1, order_id: 2
OrderDetail.create! id:6, quantity: 1, price: 19, product_id: 1, order_id: 3
