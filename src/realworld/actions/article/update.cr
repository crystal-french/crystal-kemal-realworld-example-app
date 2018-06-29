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

      article.body  = params["body"].as_s if params["body"]?
      article.title = params["title"].as_s if params["title"]?
      article.description = params["description"].as_s if params["description"]?
      
      article.slug = article.title.not_nil!.downcase.gsub(/[^\w]/, "").gsub(/\s+/, "-")

      article.tags = Repo.get_association(article, :tags).as(Array(Tag))
      article.favorites = Repo.get_association(article, :favorites).as(Array(Favorite))
      article.user = user

      new_tags = params["tagList"].as_a.uniq.map do |tag_name|
        Tag.new.tap do |tag|
          tag.article = article
          tag.name = tag_name.as_s
        end
      end

      changeset = Repo.update(article)
      if changeset.valid?
        if new_tags
          Repo.delete_all(Tag, Repo::Query.where(article_id: article.id))
          new_tags.each do |nt|
            Repo.insert(nt)  
          end
          article.tags = new_tags
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