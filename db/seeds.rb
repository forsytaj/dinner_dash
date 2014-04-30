['Appetizers', 'Salads', 'Entrees', 'Desserts'].each do |c|
  Category.create title: c
end 

Sale.create title: 'Appetizer Special', discount: 10

Item.create title: 'Cheeseburger', description: 'This is a cheeseburger.', category: Category.find_by_title('Entrees'), price: 10
Item.create title: 'Caesar Salad', description: 'This is a caesar salad.', category: Category.find_by_title('Salads'), price: 7
Item.create title: 'Cheese Sticks', description: 'These are cheese sticks.', category: Category.find_by_title('Appetizers'), price: 5, sale: Sale.first
Item.create title: 'Cheesecake', description: 'This is cheesecake.', category: Category.find_by_title('Desserts'), price: 8

User.create name: 'Addy Admin', email: 'admin@email.com', password: 'dog', password_confirmation: 'dog', admin: true
User.create name: 'Test User', email: 'user@email.com', password: 'cat', password_confirmation: 'cat', admin: false

Order.create items: [Item.find_by_title('Cheeseburger'), Item.find_by_title('Cheese Sticks')], user: User.find_by_email('user@email.com')

