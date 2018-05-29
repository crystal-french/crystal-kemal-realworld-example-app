require "../base"

module Realworld::Actions::User
  class CurrentUser < Realworld::Actions::Base
    def call(env, user)
      if user
        # TODO: return success
      else
        # TODO: return error
      end
    end
  end
end