require "./env"
require "./realworld/models/*"
require "./realworld/services/*"
require "./realworld/handlers/*"
require "./realworld/routes"

require "kemal"

add_context_storage_type(Realworld::Models::User?)

add_handler(Realworld::Handlers::AuthRequiredHandler.new)
add_handler(Realworld::Handlers::AuthOptionalHandler.new)

before_all do |env|
  env.response.content_type = "application/json"
end

Kemal.run
