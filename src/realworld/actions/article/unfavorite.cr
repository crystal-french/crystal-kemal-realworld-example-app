require "../base"

module Realworld::Actions::Article
  class Unfavorite < Realworld::Actions::Base
    include Realworld::Models

    def call(env)
      user = env.get("auth").as(User)
      # TODO: Logic
    end
  end
end