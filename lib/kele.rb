require 'pry'
require 'httparty'
require 'json'
require 'kele/roadmaps_and_checkpoints'

class Kele
  include HTTParty
  include RoadmapsAndCheckpoints

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

  def get_me_body
    JSON.parse(get_me.body)
  end

  def get_my_mentor_id
    JSON.parse(get_me.body)["current_enrollment"]["mentor_id"]
  end

  def get_my_roadmap_id
    JSON.parse(get_me.body)["current_enrollment"]["roadmap_id"]
  end

  def get_mentor_availability(mentor_id)
    url = 'https://www.bloc.io/api/v1/mentors/' + mentor_id.to_s + '/student_availability'
    get_parse(url)
  end

  def get_messages(page=1)
    url = "https://www.bloc.io/api/v1/message_threads"
    response = self.class.get(url, headers: {authorization: @auth_token}, body: {page: page})
    JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, thread_token=nil, subject, body)
    url = "https://www.bloc.io/api/v1/messages"
    if thread_token == nil
      response = self.class.post(url,
        headers: {authorization: @auth_token},
        body:{
          "sender": sender,
          "recipient_id": recipient_id,
          "subject": subject,
          "stripped-text": body
        })
    else
      response = self.class.post(url,
        headers: {authorization: @auth_token},
        body:{
          "sender": sender,
          "recipient_id": recipient_id,
          "token": thread_token,
          "subject": subject,
          "stripped-text": body
      })
    end
  end

  def get_me
    response = self.class.get('https://www.bloc.io/api/v1/users/me',
    headers: {authorization: @auth_token})
  end

  def get_parse(url)
    response = self.class.get(url, headers: {authorization: @auth_token})
    JSON.parse(response.body)
  end
end
