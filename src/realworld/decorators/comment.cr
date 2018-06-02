require "json"
require "../models/user"
require "../models/comment"
require "./profile"

module Realworld::Decorators
  class Comment
    def initialize(@comment : Realworld::Models::Comment, @viewer : Realworld::Models::User?)
    end

    def to_json(builder : JSON::Builder)
      
      builder.object do
        builder.field("id", @comment.id)
        builder.field("createdAt", @comment.created_at.not_nil!.to_s("%FT%X%z").gsub(/\+0000/, "Z"))
        builder.field("updatedAt", @comment.updated_at.not_nil!.to_s("%FT%X%z").gsub(/\+0000/, "Z"))
        builder.field("body", @comment.body)
        builder.field("author") do
          Profile.new(@comment.user, @viewer).to_json(builder)
        end
      end

    end
  end  
end