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

