# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = FactoryBot.create(:user)
user.add_role :user
user.password = 'qwertyuiop'
user.password_confirmation = 'qwertyuiop'
user.save

puts 'User Info:'
puts "email: #{user.email}"
puts 'password: qwertyuiop'

puts '======================'

manager = FactoryBot.create(:user)
manager.add_role :manager
manager.password = 'qwertyuiop'
manager.password_confirmation = 'qwertyuiop'
manager.save

puts 'Manager Info:'
puts "email: #{manager.email}"
puts 'password: qwertyuiop'