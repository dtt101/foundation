# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
User.create([
  { username: 'foo', email: 'foo@example.com', password: 'password', password_confirmation: 'password' },
  { username: 'bar', email: 'bar@example.com', password: 'password', password_confirmation: 'password' }
])
