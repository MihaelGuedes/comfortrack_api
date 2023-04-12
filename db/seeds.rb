require 'faker'
require 'factory_bot_rails'

# Criando Politicas de Grupo e Permissionamento
admin_group = GroupPolicy.find_or_create_by!(name: 'Admin', user_type: :admin)
tutor_group = GroupPolicy.find_or_create_by!(name: 'Tutor', user_type: :tutor)
suporte_group = GroupPolicy.find_or_create_by!(name: 'Suporte', user_type: :tutor)


Permission.find_or_create_by!(resource: :user) do |permission|
  permission.group_policies << admin_group
end


User::Admin.find_or_create_by!(name: 'Admin User', email: 'admin@dev.com') do |user|
  user.password = 'teste1234'
end

User::Tutor.find_or_create_by!(name: 'Tutor User', email: 'tutor@comfortrack.com') do |user|
  user.password = 'teste1234'
end

User::Suporte.find_or_create_by!(name: 'Suporte User', email: 'suporte@comfortrack.com') do |user|
  user.password = 'teste1234'
end

Plan.find_or_create_by!(name: 'Básico', price: 0, type_plan: :basic, months: 0)
Plan.find_or_create_by!(name: 'Ouro', price: 200, type_plan: :gold, months: 1)
Plan.find_or_create_by!(name: 'Platina', price: 1000, type_plan: :platinum, months: 6)
Plan.find_or_create_by!(name: 'Diamante', price: 1600, type_plan: :diamond, months: 12)

