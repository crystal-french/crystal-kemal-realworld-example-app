require "jwt"
require "./repo"
require "../models/user"

module Realworld::Services
  class Auth
    Algorithm = ENV["JWT_ALGORITHM"]
    Secret = ENV["JWT_SECRET"]

    def self.auth(header : String?)
      match = /^(Bearer|Token) (?<token>.+)$/.match(header.not_nil!)
      payload, token_header = JWT.decode(match.not_nil!["token"], Secret, Algorithm)
      id = payload.as(Hash)["id"].as(Int64)
      user = Repo.get!(Realworld::Models::User, id, Repo::Query.preload(:followed_users))
    end

    # TODO: Move somewhere else?
    def self.generate_jwt(user : User)
      payload = {
        "id" => user.id,
        "exp" => Time.now + 30.days
      }
      JWT.encode(payload, Secret, Algorithm)
    end
  end
end