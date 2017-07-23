require 'pry'
require 'httparty'
require 'json'

class Kele
  include HTTParty
  def initialize(email, password)
    @email = email
    @password = password
    @api = "https://www.bloc.io/api/v1"
    @auth_token = set_session_token
  end



  def set_session_token
    response = self.class.post('https://www.bloc.io/api/v1/sessions',
      body: {
        email: @email,
        password: @password
      })

    response["auth_token"]
  end

  def get_me
    response = self.class.get('https://www.bloc.io/api/v1/users/me',
      headers: {authorization: @auth_token})  
    JSON.parse(response.body)
  end
end
