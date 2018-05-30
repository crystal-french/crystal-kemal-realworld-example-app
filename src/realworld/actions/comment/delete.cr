require "../base"
require "../../models/article"
require "../../models/comment"
require "../../services/repo"

module Realworld::Actions::Comment
  class Delete < Realworld::Actions::Base
    def call(env, user)
      if user
        article = Realworld::Services::Repo.get_by(Realworld::Models::Article, slug: env.params.url["slug"])
        if article
          if id = env.params.url["slug"].to_i64?
            comment = Realworld::Services::Repo.get(Realworld::Models::Comment, id)
            if comment && article.id == comment.article_id && user.id == comment.user_id
              changeset = Realworld::Services::Repo.delete(comment)

              # TODO: return success
            else
              # TODO: return error
            end
          else
            # TODO: return error
          end
        else
          # TODO: return error
        end  
      else
        # TODO: return error
      end
    end
  end
end