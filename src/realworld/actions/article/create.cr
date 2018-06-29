require "../base"
require "../../errors"
require "../../models/user"
require "../../models/article"
require "../../models/favorite"
require "../../models/tag"
require "../../services/repo"
require "../../decorators/article"
require "../../decorators/errors"

module Realworld::Actions::Article
  class Create < Realworld::Actions::Base
    include Realworld::Models
    include Realworld::Services
    
    def call(env)
      user = env.get("auth").as(User)
      
      params = env.params.json["article"].as(Hash)

      article = Article.new
      article.title = params["title"].as_s
      article.body  = params["body"].as_s
      article.description = params["description"].as_s
      
      article.slug = article.title.not_nil!.downcase.gsub(/[^\w ]/, "").gsub(/\s+/, "-")
      
      article.user = user
      article.tags = [] of Tag
      article.favorites = [] of Favorite 

      changeset = Repo.insert(article)
      if changeset.valid?
        article.id = changeset.instance.id

        article.tags = params["tagList"].as_a.uniq.map do |tag|
          t = Tag.new
          t.name = tag.as_s
          t.article = article
          t_changeset = Repo.insert(t)
          t_changeset.instance
        end  

        response = {"article" => Realworld::Decorators::Article.new(article, user)}
        response.to_json
      else
        errors = {"errors" => Realworld::Decorators::Errors.new(changeset.errors)}
        raise Realworld::UnprocessableEntityException.new(env, errors.to_json)
      end
    end
  end
end