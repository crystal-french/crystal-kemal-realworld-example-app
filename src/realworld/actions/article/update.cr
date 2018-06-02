require "../base"
require "../../errors"
require "../../models/user"
require "../../models/article"
require "../../services/repo"
require "../../decorators/article"
require "../../decorators/errors"

module Realworld::Actions::Article
  class Update < Realworld::Actions::Base
    include Realworld::Models
    include Realworld::Services

    def call(env)
      user = env.get("auth").as(User)
      
      slug = env.params.url["slug"]
      params = env.params.json["article"].as(Hash)

      article = Repo.get_by(Article, slug: slug)
      raise Realworld::NotFoundException.new(env) if !article
      raise Realworld::ForbiddenException.new(env) if article.user_id != user.id

      article.body  = params["body"].as(String) if params["body"]?
      article.title = params["title"].as(String) if params["title"]?
      article.description = params["description"].as(String) if params["description"]?

      article.slug = article.title.not_nil!.downcase.gsub(/[^\w]/, "").gsub(/\s+/, "-")

      changeset = Repo.update(article)
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