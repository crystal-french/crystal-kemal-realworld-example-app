require "json"
require "../models/user"
require "../models/article"
require "./profile"
require "./tag_list"

module Realworld::Decorators
  class Article
    def initialize(@article : Realworld::Models::Article, @viewer : Realworld::Models::User?)
    end

    def to_json(builder : JSON::Builder)
      favorited = false

      if auth_user = @viewer
        favorited = @article.favorites.select {|f| f.user_id == auth_user.id }.size > 0
      end

      builder.object do
        builder.field("slug", @article.slug)
        builder.field("title", @article.title)
        builder.field("description", @article.description)
        builder.field("body", @article.body)
        builder.field("tagList") do
          TagList.new(@article.tags).to_json(builder)
        end
        builder.field("createdAt", @article.created_at.not_nil!.to_s("%FT%X%z").gsub(/\+0000/, "Z"))
        builder.field("updatedAt", @article.updated_at.not_nil!.to_s("%FT%X%z").gsub(/\+0000/, "Z"))
        builder.field("favorited", favorited)
        builder.field("favoritesCount", @article.favorites.size)
        builder.field("author") do
          Profile.new(@article.user, @viewer).to_json(builder)
        end
      end        

    end
  end
end