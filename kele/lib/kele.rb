require "kele/version"
require './lib/kele'
require 'httparty'

class Kele
    include HTTParty
    
    def initialize(email, password)
        response = self.class.post(api_url('sessions'), body: { "email": email, "password": password })
        @auth_token = response["auth_token"]
    end
end