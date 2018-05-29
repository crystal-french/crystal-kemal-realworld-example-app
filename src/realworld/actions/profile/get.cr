require "../base"
require "../../models/user"
require "../../services/repo"

module Realworld::Actions::Profile
  class Get < Realworld::Actions::Base
    def call(env, user)
      owner = Realworld::Services::Repo.get_by(Realworld::Models::User, username: env.params.url["username"])
      if owner
        # TODO: user.to_profile
        # TODO: Return success
      else
        # TODO: Return error
      end
    end
  end
end