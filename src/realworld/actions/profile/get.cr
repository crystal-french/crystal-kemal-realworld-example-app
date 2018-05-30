require "../base"
require "../../models/user"
require "../../services/repo"

module Realworld::Actions::Profile
  class Get < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models
    
    def call(env, user)
      owner = Repo.get_by(User, username: env.params.url["username"])
      if owner
        # TODO: user.to_profile
        # TODO: Return success
      else
        # TODO: Return error
      end
    end
  end
end