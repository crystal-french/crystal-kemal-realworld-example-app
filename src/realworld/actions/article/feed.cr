require "../base"

module Realworld::Actions::Article
  class Feed < Realworld::Actions::Base
    include Realworld::Models

    def call(env)
      user = env.get("auth").as(User)
      # TODO: Logic
    end
  end
end