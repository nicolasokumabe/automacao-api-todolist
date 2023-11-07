require "httparty"

class BaseApi
  include HTTParty
  base_uri "http://localhost:8080"
end
