require "../base"
require "../../services/repo"

module Realworld::Actions::Tag
  class List < Realworld::Actions::Base
    def call(env)
      tags = Realworld::Services::Repo.all(Tag)
      # TODO: Return success
    end
  end  
end