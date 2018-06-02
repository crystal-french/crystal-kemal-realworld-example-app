require "json"
require "../models/tag"

module Realworld::Decorators
  class TagList
    def initialize(@tags : Array(Realworld::Models::Tag))
    end

    def to_json(builder : JSON::Builder)

      builder.array do
        @tags.each { |tag| builder.string(tag.name) }
      end
      
    end
  end
end