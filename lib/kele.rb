require 'pry'
require 'httparty'

class Kele
  include HTTParty
  def initialize(email, password)
    @email = email
    @password = password
    @api = "https://www.bloc.io/api/v1"
    @token = set_session_token
  end



  def set_session_token
    response = self.class.post('https://www.bloc.io/api/v1/sessions',
      body: {
        email: @email,
        password: @password
      })

    response["auth_token"]
  end
end
