require 'faker'
require 'factory_bot_rails'

# Criando Politicas de Grupo e Permissionamento
admin_group = GroupPolicy.find_or_create_by!(name: 'Admin', user_type: :admin)
tutor_group = GroupPolicy.find_or_create_by!(name: 'Tutor', user_type: :tutor)
suporte_group = GroupPolicy.find_or_create_by!(name: 'Suporte', user_type: :tutor)


Permission.find_or_create_by!(resource: :user) do |permission|
  permission.group_policies << admin_group
end


User::Admin.find_or_initialize_by(name: 'Admin User', email: 'admin@dev.com') do |user|
  user.password = 'teste1234'
  user.gender = 'female'
  user.cep = '50820121'
  user.neighborhood = 'Imbiribeira'
  user.address = 'Rua tal 103'
  user.city = 'Recife'
  user.birth_date = '1998-02-20'.to_date
  user.save
end

User::Tutor.find_or_initialize_by(name: 'Tutor User', email: 'tutor@comfortrack.com') do |user|
  user.password = 'teste1234'
  user.gender = 'male'
  user.cep = '50820121'
  user.address = 'Rua tal 20'
  user.neighborhood = 'Imbiribeira'
  user.city = 'Recife'
  user.birth_date = '1998-05-23'.to_date
  user.save
end

User::Suporte.find_or_initialize_by(name: 'Suporte User', email: 'suporte@comfortrack.com') do |user|
  user.password = 'teste1234'
  user.gender = 'male'
  user.cep = '50820121'
  user.address = 'Rua tal 150'
  user.neighborhood = 'Imbiribeira'
  user.city = 'Recife'
  user.birth_date = '1996-12-29'.to_date
  user.save
end

Plan.find_or_create_by!(name: 'Básico', price: 0, type_plan: :basic, months: 0)
Plan.find_or_create_by!(name: 'Ouro', price: 200, type_plan: :gold, months: 1)
Plan.find_or_create_by!(name: 'Platina', price: 1000, type_plan: :platinum, months: 6)
Plan.find_or_create_by!(name: 'Diamante', price: 1600, type_plan: :diamond, months: 12)

Product.find_or_create_by!(name: 'Coleira Rastreadora', price: 300, product_type: :collar,
                           description: 'Coleira peitoral feita com nylon e malha de poliéster')
Product.find_or_create_by!(name: 'Bateria 6600mAh', price: 60, product_type: :battery,
                           description: 'Bateria recarregável de íon de lítio de 6600mAh.')
Product.find_or_create_by!(name: 'Bateria 3800mAh', price: 35, product_type: :battery,
                           description: 'Bateria recarregável de íon de lítio de 3800mAh.')
Product.find_or_create_by!(name: 'Fecho de Nylon', price: 4, product_type: :clasp,
                           description: 'Fecho engate rápido para coleiras em cores variadas.')

