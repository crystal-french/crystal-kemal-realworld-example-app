require "../base"
require "../../errors"
require "../../models/user"
require "../../models/article"
require "../../models/tag"
require "../../services/repo"

module Realworld::Actions::Article
  class Delete < Realworld::Actions::Base
    include Realworld::Models
    include Realworld::Services

    def call(env)
      user = env.get("auth").as(User)
      
      slug = env.params.url["slug"]

      article = Repo.get_by(Article, slug: slug)
      raise Realworld::NotFoundException.new(env) if !article

      if article.user_id == user.id
        article.tags = Repo.get_association(article, :tags).as(Array(Tag))
        changeset = Repo.delete(article)
        if !changeset.valid?
          errors = {"errors" => map_changeset_errors(changeset.errors)}
          raise Realworld::UnprocessableEntityException.new(env, errors.to_json)
        end
      else
        raise Realworld::ForbiddenException.new(env)
      end
    end
  end
end