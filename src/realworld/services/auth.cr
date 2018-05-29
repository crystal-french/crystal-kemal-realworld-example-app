require "jwt"
require "./repo"

module Realworld::Services
  class Auth
    Algorithm = ENV["JWT_ALGORITHM"]
    Secret = ENV["JWT_SECRET"]

    def self.auth(header)
      match = /^(Bearer|Token) (?<token>.+)$/.match(auth_header.to_s)
      begin
        payload, header = JWT.decode(match.not_nil!["token"], Secret, Algorithm)
        id = payload.as(Hash(String, JSON::Type))["id"].as(Int64)
        user = Repo.get!(User, id)
      rescue exception
        nil
      end
    end
  end
end