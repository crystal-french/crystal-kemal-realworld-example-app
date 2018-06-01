require "../base"
require "../../errors"
require "../../models/user"
require "../../services/repo"

module Realworld::Actions::Profile
  class Get < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models
    
    def call(env)
      user = env.get("auth").as(User?)
      
      p_owner = Repo.get_by(User, username: env.params.url["username"])
      raise Realworld::NotFoundException.new(env) if !p_owner

      # TODO: user.to_profile
      # TODO: Return success
    end
  end
end