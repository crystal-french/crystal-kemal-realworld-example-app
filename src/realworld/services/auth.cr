require "jwt"
require "./repo"
require "../models/user"

module Realworld::Services
  class Auth
    ALGORITHM = JWT::Algorithm.parse(ENV["JWT_ALGORITHM"])
    SECRET    = ENV["JWT_SECRET"]

    def self.auth(header : String)
      match = /^(Bearer|Token) (?<token>.+)$/.match(header)
      raise "Invalid Authorization string" if !match

      token_payload, token_header = JWT.decode(match["token"], SECRET, ALGORITHM)
      
      id = token_payload["id"].as_i64
      user = Repo.get!(Realworld::Models::User, id, Repo::Query.preload(:followed_users))
    end

    def self.jwt_for(user : Realworld::Models::User)
      payload = { "id" => user.id, "exp" => (Time.local + 30.days).to_unix }
      JWT.encode(payload, SECRET, ALGORITHM)
    end
  end
end