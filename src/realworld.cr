require "./env"
require "./realworld/models/*"
require "./realworld/services/*"
require "./realworld/handlers/*"
require "./realworld/version"
require "./realworld/errors"
require "./realworld/routes"

require "kemal"

add_context_storage_type(Realworld::Models::User?)

add_handler(Realworld::Handlers::AuthRequiredHandler.new)
add_handler(Realworld::Handlers::AuthOptionalHandler.new)

error 401 {|env| ""}
error 403 {|env| ""}
error 404 {|env| ""}

error 422 do |env, exception| 
  errors = exception.as(Realworld::UnprocessableEntityException).content
  {"errors" => errors}.to_json
end

before_all {|env| env.response.content_type = "application/json"}

Kemal.run
