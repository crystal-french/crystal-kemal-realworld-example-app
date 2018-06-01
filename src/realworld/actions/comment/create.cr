require "../base"
require "../../models/article"
require "../../models/comment"
require "../../services/repo"

module Realworld::Actions::Comment
  class Create < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models

    def call(env)
      user = env.get("auth").as(User)
      article = Repo.get_by(Article, slug: env.params.url["slug"])
      if article
        comment = Comment.new
        comment.body = env.params.json["comment"].as(Hash)["body"].as(String)
        comment.user = user
        comment.article = article

        changeset = Repo.insert(comment)
        if changeset.valid?
          # TODO: return success
        else
          # TODO: return error
        end
      else
        # TODO: return error
      end  
    end
  end
end