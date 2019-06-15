# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#
# ARTICLE STATES
if ArticleState.all.empty?
  ArticleState.create!([{id: 1, name: 'new'}, {id: 2, name: 'in_use'}, {id: 3, name: 'returned'}, {id: 4, name: 'kept'}])
end
