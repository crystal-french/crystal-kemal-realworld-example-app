require "../base"
require "../../models/tag"
require "../../services/repo"

module Realworld::Actions::Tag
  class List < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models

    def call(env)
      tags = Repo.all(Tag)
      {"tags" => tags.map(&.name)}.to_json
    end
  end  
end