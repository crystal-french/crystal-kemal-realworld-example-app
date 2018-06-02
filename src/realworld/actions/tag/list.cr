require "../base"
require "../../models/tag"
require "../../services/repo"
require "../../decorators/tag_list"

module Realworld::Actions::Tag
  class List < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models

    def call(env)
      query = Repo::Query.distinct("tags.name")
      tags = Repo.all(Tag, query)
      
      response = {"tags" => Realworld::Decorators::TagList.new(tags)}
      response.to_json
    end
  end  
end