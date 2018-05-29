require "jwt"
require "./repo"
require "../models/user"

module Realworld::Services
  class Auth
    Algorithm = ENV["JWT_ALGORITHM"]
    Secret = ENV["JWT_SECRET"]

    def self.auth(header : String?)
      match = /^(Bearer|Token) (?<token>.+)$/.match(auth_header.to_s)
      begin
        payload, header = JWT.decode(match.not_nil!["token"], Secret, Algorithm)
        id = payload.as(Hash(String, JSON::Type))["id"].as(Int64)
        user = Repo.get!(Realworld::Models::User, id)
      rescue exception
        nil
      end
    end

    def self.generate_jwt(user : User)
      payload = {
        "id" => user.id,
        "exp" => Time.now + 30.days
      }
      JWT.encode(payload, Secret, Algorithm)
    end
  end
end