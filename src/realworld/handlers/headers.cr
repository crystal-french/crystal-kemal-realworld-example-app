require "kemal"

module Realworld::Handlers
  class ContentTypeHandler < Kemal::Handler
    def call(env)
      env.response.content_type = "application/json"
      call_next(env)
    end
  end

  class CorsHandler < Kemal::Handler
    def call(env)
      env.response.headers["Access-Control-Allow-Origin"] = "*"
      call_next(env)
    end    
  end
end