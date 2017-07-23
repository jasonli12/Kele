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
    @my_mentor_id = get_my_mentor_id
  end



  def set_session_token
    response = self.class.post('https://www.bloc.io/api/v1/sessions',
      body: {
        email: @email,
        password: @password
      })

    response["auth_token"]
  end

  def get_me_body
    JSON.parse(get_me.body)
  end

  def get_my_mentor_id
    response = self.class.get('https://www.bloc.io/api/v1/users/me',
      headers: {authorization: @auth_token})
    JSON.parse(get_me.body)["current_enrollment"]["mentor_id"]
  end

  def get_mentor_availability(mentor_id)
    url = 'https://www.bloc.io/api/v1/mentors/'+ mentor_id.to_s+ '/student_availability'
    response = self.class.get(url, headers: {authorization: @auth_token})
    JSON.parse(response.body)
  end

  def get_me
    response = self.class.get('https://www.bloc.io/api/v1/users/me',
    headers: {authorization: @auth_token})
  end
end
