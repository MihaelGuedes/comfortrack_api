require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:permission) { create(:permission, resource: :user) }
  let!(:current_user) { create(:user, :admin) }
  let!(:other_user) { create(:user, :admin) }
  let!(:user_without_permission) { create(:user, :admin) }
  
  describe 'GET /index' do
    context 'with permission' do
      it 'returns http success' do
        get users_url, headers: login_as(current_user)
        expect(response).to custom_have_http_status(200)

        result_index = body_json['data'].first

        expect(result_index['id']).to eq(current_user.id)
        expect(result_index['name']).to eq(current_user.name)
        expect(result_index['email']).to eq(current_user.email)
        expect(result_index['user_type']).to eq(current_user.user_type)
        expect(result_index['status']).to eq(current_user.status)
        expect(result_index['phone']).to eq(current_user.phone)
        expect(result_index['avatar']).to eq(current_user.avatar)
      end
    end

    context 'without permission' do
      xit 'returns http forbidden' do
        get users_url, headers: login_as(user_without_permission)
        expect(response).to custom_have_http_status(403)
        expect(body_json.first).to eq('Você não tem autorização para acessar este recurso')
      end
    end
  end

  describe 'GET /show' do
    context 'with permission' do
      it 'returns http success' do
        get user_url(other_user.id), headers: login_as(current_user)
        
        expect(response).to custom_have_http_status(200)
        expect(body_json['id']).to eq(other_user.id)
        expect(body_json['name']).to eq(other_user.name)
        expect(body_json['email']).to eq(other_user.email)
        expect(body_json['user_type']).to eq(other_user.user_type)
        expect(body_json['status']).to eq(other_user.status)
        expect(body_json['phone']).to eq(other_user.phone)
        expect(body_json['avatar']).to eq(other_user.avatar)
      end
    end
    
    # Comentado por que mudamos o sistema de permissionamento pro MVP
    # context 'without permission' do
    #   it 'returns http forbidden' do
    #     get user_url(other_user.id), headers: login_as(user_without_permission)
    #     expect(response).to custom_have_http_status(403)
    #   end
    # end
  end

  describe 'POST /create' do
    describe 'with valid request' do
      context 'when user_type: admin' do
        let(:params){ { user: { name: 'Test User', email: 'test.user@email.com', status: :active,
                                password: '123456', password_confirmation: '123456', user_type: :admin
          }}
        }

        before do
          post users_url, params:, headers: login_as(current_user)
        end

        it 'have http success' do
          expect(response).to custom_have_http_status(201)

          user_created = User.last

          expect(user_created.admin?).to be true
          expect(user_created.active?).to be true
          expect(user_created.email).to eq(params[:user][:email])
        end

        it 'have created user' do
          expect(User.last.name).to eq(params[:user][:name])
        end

        # Comentado por que mudamos o sistema de permissionamento pro MVP
        # it 'user have 1 permission' do
        #   expect(User.last.permissions.count).to eq(1)
        # end
      end

      context 'when user_type: tutor' do
        let(:params){ { user: { name: 'Test User', email: 'test.user@email.com', status: :active,
            password: '123456', password_confirmation: '123456', user_type: :tutor,
          }}
        }

        it 'have http success' do
          post users_url, params:, headers: login_as(current_user)

          expect(response).to custom_have_http_status(201)
          user_created = User.last

          expect(user_created.active?).to be true
          expect(user_created.email).to eq(params[:user][:email])

          expect(user_created.name).to eq(params[:user][:name])
        end

         # Comentado por que mudamos o sistema de permissionamento pro MVP

        # it 'user have 1 permission' do
        #   expect(User.last.permissions.count).to eq(1)
        # end
      end
    end

    context 'with invalid request' do
      it 'have http unprocessable_entity - with invalid password_confirmation' do
        params = { user: { name: 'Test User', email: 'test.user@email.com', status: :active, password: '123456', 
          password_confirmation: '12345', user_type: :admin
        }}
        post users_url, params: params, headers: login_as(current_user)
        expect(response).to custom_have_http_status(422)
        expect(body_json.first).to eq('Password_confirmation não é igual a Senha')
      end

      it 'have http unprocessable_entity - with email blank' do
        params = { user: { name: 'Test User', email: '', status: :active, password: '123456', 
          password_confirmation: '123456', user_type: :admin
        }}
        post users_url, params: params, headers: login_as(current_user)
        expect(response).to custom_have_http_status(422)
        expect(body_json.first).to eq('Email não pode ficar em branco')
      end

      it 'have http unprocessable_entity - with name blank' do
        params = { user: { name: '', email: 'test.user@email.com', status: :active, password: '123456', 
          password_confirmation: '123456', user_type: :admin
        }}
        post users_url, params: params, headers: login_as(current_user)
        expect(response).to custom_have_http_status(422)
        expect(body_json.first).to eq('Name não pode ficar em branco')
      end

      it 'have http forbidden with user without permission' do
        params = { user: { name: 'Test User', email: 'test.user@email.com', status: :active, password: '123456', 
          password_confirmation: '12345s', user_type: :admin
        }}
        post users_url, params: params, headers: login_as(user_without_permission)
        expect(response).to custom_have_http_status(422)
        expect(body_json.first).to eq('Password_confirmation não é igual a Senha')
      end
    end
  end

  describe 'PUT /update' do
    context 'with valid request' do
      let(:params) { { user: { password: 'NovaSenhaSegura', password_confirmation: 'NovaSenhaSegura' } } }

      before do
        put user_url(other_user.id), params:, headers: login_as(current_user)
      end

      it 'returns http success' do
        expect(response).to custom_have_http_status(200)

        expect(body_json['id']).to eq(other_user.id)
        expect(body_json['name']).to eq(other_user.name)
        expect(body_json['email']).to eq(other_user.email)
        expect(body_json['user_type']).to eq(other_user.user_type)
        expect(body_json['status']).to eq(other_user.status)
        expect(body_json['phone']).to eq(other_user.phone)
        expect(body_json['avatar']).to eq(other_user.avatar)
      end
    end

    context 'with invalid request' do
      let(:params) { { user: { password: 'NovaSenhaSegura', password_confirmation: 'NovaSenhaSeguraDiferente' } } }

      before do
        put user_url(other_user.id), params:, headers: login_as(current_user)
      end

      it 'returns http unprocessable_entity' do
        expect(response).to custom_have_http_status(422)
        expect(body_json.first).to eq('Password_confirmation não é igual a Senha')
      end
    end

    # Comentado por que mudamos o sistema de permissionamento pro MVP
    # context 'without permission' do
    #   let(:params) { { user: { password: 'NovaSenhaSegura', password_confirmation: 'NovaSenhaSegura' } } }

    #   it 'returns http forbidden' do
    #     put user_url(other_user.id), params: params, headers: login_as(user_without_permission)
    #     expect(response).to custom_have_http_status(403)
    #   end
    # end
  end

  describe 'DELETE /destroy' do
    context 'with permission' do
      before do
        delete user_url(other_user.id), headers: login_as(current_user)
      end

      it 'returns http success' do
        expect(response).to custom_have_http_status(204)
        expect(response.body).to be_empty
      end

      it 'user status is inactive' do
        expect(other_user.reload.status).to eq('inactive')
      end
    end

    # Comentado por que mudamos o sistema de permissionamento pro MVP
    # context 'without permission' do
    #   before do
    #     delete user_url(other_user.id), headers: login_as(user_without_permission)
    #   end

    #   it 'returns http forbidden' do
    #     expect(response).to custom_have_http_status(403)
    #   end

    #   it 'user status is inactive' do
    #     expect(other_user.reload.status).to eq('active')
    #   end
    # end
  end
  
end
