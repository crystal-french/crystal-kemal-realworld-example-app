require "../base"
require "../../errors"
require "../../models/user"
require "../../models/article"
require "../../services/repo"
require "../../decorators/article"
require "../../decorators/errors"

module Realworld::Actions::Article
  class Create < Realworld::Actions::Base
    include Realworld::Models
    include Realworld::Services
    
    def call(env)
      user = env.get("auth").as(User)
      
      article = Article.new
      article.title = env.params.json["article"].as(Hash)["title"].as(String)
      article.body  = env.params.json["article"].as(Hash)["body"].as(String)
      article.description = env.params.json["article"].as(Hash)["description"].as(String)
      
      article.slug = article.title.not_nil!.downcase.gsub(/[^\w]/, "").gsub(/\s+/, "-")

      env.params.json["article"].as(Hash)["tagList"]?.try do |tag_list|
        tag_list.as(Array).uniq.each do |tag|
          t = Tag.new
          t.name = tag.as(String)
          t.article = article
          article.tags << t
        end
      end

      changeset = Repo.insert(article)
      if changeset.valid?
        response = {"article" => Realworld::Decorators::Article.new(changeset.instance, user)}
        response.to_json
      else
        errors = {"errors" => Realworld::Decorators::Errors.new(changeset.errors)}
        raise Realworld::UnprocessableEntityException.new(env, errors.to_json)
      end
    end
  end
end