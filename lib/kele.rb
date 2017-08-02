require "kele/version"
require './lib/kele'
require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
    include HTTParty
    include Roadmap
    
    def initialize(email, password)
        response = self.class.post(api_url('sessions'), body: { "email": email, "password": password })
        @auth_token = response["auth_token"]
    end
    
    def api_url(url)
        "https://www.bloc.io/api/v1/#{url}"
    end
    
    def get_me
        response = self.class.get(api_url('users/me'), headers: { "authorization" => @auth_token })
        @user_data = JSON.parse(response.body)
    end
    
    def create_message(user_id, recipient_id, token, subject, stripped)
        options = {body: {user_id: user_id, recipient_id: recipient_id, token: nil, subject: subject, stripped: stripped}, headers: { "authorization" => @auth_token }}
        self.class.post(api_url("messages"), options)
    end
    
    def get_messages(arg = nil)
        response = self.class.get(api_url("message_threads"), headers: { "authorization" => @auth_token })
        body = JSON.parse(response.body)
        pages = (1..(response["count"]/10 + 1)).map do |n|
            self.class.get(api_url("message_threads"), body: { page: n }, headers: { "authorization" => @auth_token })
        end
    end
    
    def get_mentor_availability 
        response = self.class.get(api_url("mentors/#{current_enrollment['mentor_id']}/student_availability"), user_auth)
        @mentor_availability = JSON.parse(response.body)
    end
    
    def user_auth
        {headers: {
            authorization: @auth_token
        }}
    end
end