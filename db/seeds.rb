# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

provider = Provider.create(email: "some@email.com", category: Category.all.first[0],
  first_name: "Leandro", last_name: "Gon", phone: "123456", address: "codika", iva: "21%")

provider.products.create(name: "Producto 1", description: "Esta es la descripcion 1",
  price: "10")

provider.products.create(name: "Producto 2", description: "Esta es la descripcion 2",
  price: "10", discount_price: "8", is_discount: true)
