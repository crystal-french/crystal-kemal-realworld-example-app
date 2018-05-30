require "../base"
require "../../models/tag"
require "../../services/repo"

module Realworld::Actions::Tag
  class List < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models

    def call(env)
      tags = Repo.all(Tag)
      # TODO: Return success
    end
  end  
end