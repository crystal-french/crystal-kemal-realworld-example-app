require "../base"
require "../../models/user"

module Realworld::Actions::User
  class CurrentUser < Realworld::Actions::Base
    include Realworld::Models

    def call(env)
      user = env.get("auth").as(User)
      # TODO: return success
    end
  end
end