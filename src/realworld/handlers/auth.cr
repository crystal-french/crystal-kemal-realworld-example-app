require "kemal"
require "../services/auth"

module Realworld::Handlers
  class AuthRequiredHandler < Kemal::Handler
    include Realworld::Services

    only ["/api/user", "/api/articles"], "PUT"
    only ["/api/user", "/api/articles/feed"], "GET"
    only ["/api/profiles/:username/follow", "/api/articles", "/api/articles/:slug/favorite", "/api/articles/:slug/comments"], "POST"
    only ["/api/profiles/:username/follow", "/api/articles/:slug", "/api/articles/:slug/favorite", "/api/articles/:slug/comments/:id"], "DELETE"

    def call(env)
      return call_next(env) unless only_match?(env)
      begin
        env.set "auth", Auth.auth(env.request.headers["Authorization"])
      rescue exception
        env.response.status_code = 401
        env.response.print ""
        env.response.close
        return
      end
      call_next(env)
    end
  end

  class AuthOptionalHandler < Kemal::Handler
    include Realworld::Services

    only ["/api/profiles/:username", "/api/articles", "/api/articles/:slug/comments"], "GET"

    def call(env)
      return call_next(env) unless only_match?(env)
      begin
        env.set "auth", Auth.auth(env.request.headers["Authorization"])
      rescue exception
        env.set "auth", nil
      end
      call_next(env)
    end
  end
end