module Request
  module AuthHelpers
    # usado para login em controllers
    def login_as(user)
      token = JsonWebToken.jwt_encode(user_id: user.id)
      { 'Authorization' => "Bearer #{token}", 'Accept' => 'application/vnd.marketplace.v1' }
    end

    def integration_with(auth)
    	request.headers['Authorization'] = auth.token
    end

    # usado para login em requests
    def login_token(user)
      token = AuthenticateUser.call(user[:email], user[:password])
      { 'Authorization' => "Bearer #{token}", 'Accept' => 'application/vnd.marketplace.v1' }
    end


    def body_json(symbolize_keys: false)
      json = JSON.parse(response.body)
      symbolize_keys ? json.deep_symbolize_keys : json
    end
  end
end