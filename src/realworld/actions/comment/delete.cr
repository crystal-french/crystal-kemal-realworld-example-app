require "../base"
require "../../models/article"
require "../../models/comment"
require "../../services/repo"

module Realworld::Actions::Comment
  class Delete < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models
    
    def call(env, user)
      if user
        article = Repo.get_by(Article, slug: env.params.url["slug"])
        if article
          if id = env.params.url["slug"].to_i64?
            comment = Repo.get(Comment, id)
            if comment && article.id == comment.article_id && user.id == comment.user_id
              changeset = Repo.delete(comment)

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