# ComforTrack API

### Rode a infra necessária para execução da aplicação:

docker-compose up -d

### Intale as dependências da aplicação:

bundle install

### Migre o banco:

rails db:create db:migrate db:seed

### Rode o sidekiq:

bundle exec sidekiq

### Rode a aplicação:

rails s

### Verifique os testes:

bundle exec rspec