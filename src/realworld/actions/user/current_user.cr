require "../base"
require "../../models/user"
require "../../decorators/user"

module Realworld::Actions::User
  class CurrentUser < Realworld::Actions::Base
    include Realworld::Models

    def call(env)
      user = env.get("auth").as(User)
      
      response = {"user" => Realworld::Decorators::User.new(user)}
      response.to_json
    end
  end
end