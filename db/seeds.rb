# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Frecuencies
if Frecuency.all.empty?
  Frecuency.create!([{id: 1, description: 'Semanal', value: 1}])
end

# Article states
if ArticleState.all.empty?
  ArticleState.create!([{id: 1, name: 'new'}, {id: 2, name: 'in_use'}, {id: 3, name: 'returned'}, {id: 4, name: 'kept'}])
end

# Loan categories
if LoanCategory.all.empty?
  LoanCategory.create!([{id: 1, name: 'Personal'}, {id: 2, name: 'Estudio'}, {id: 3, name: 'Hipotecario'}])
end

# Article types
if ArticleType.all.empty?
  ArticleType.create!([
      {id: 1, description: 'Electrodomesticos', frecuency_id: 1},
      {id: 2, description: 'Muebles', frecuency_id: 1},
      {id: 3, description: 'joyas', frecuency_id: 1}])
end

# Loan states
if LoanState.all.empty?
  LoanState.create!([{id: 1, name: 'new'}, {id: 2, name: 'partial_payed'}, {id: 3, name: 'payed'}, {id: 4, name: 'kept'}])
end

# Loan payment frecuencies
if LoanPaymentFrecuency.all.empty?
  LoanPaymentFrecuency.create!([{id: 1, name: 'Semanas', value: 4, description: 'Mensual'}, {id: 2, name: 'Semanas', value: 12, description: 'Trimestral'}, {id: 3, name: 'Mes', value: 12, description: 'Anual'}])
end