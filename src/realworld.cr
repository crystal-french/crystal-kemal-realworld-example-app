require "./env"
require "./realworld/models/*"
require "./realworld/services/*"
require "./realworld/handlers/*"
require "./realworld/version"
require "./realworld/errors"
require "./realworld/routes"

require "kemal"

add_context_storage_type(Realworld::Models::User?)

add_handler(Realworld::Handlers::CorsHandler.new)
add_handler(Realworld::Handlers::ContentTypeHandler.new)
add_handler(Realworld::Handlers::AuthRequiredHandler.new)
add_handler(Realworld::Handlers::AuthOptionalHandler.new)

error 500 {|env| {"status" => 500, "error" => "Internal Server Error"}.to_json }
error 401 {|env| {"status" => 401, "error" => "Unauthorized"}.to_json }
error 403 {|env| {"status" => 403, "error" => "Forbidden"}.to_json }
error 404 {|env| {"status" => 404, "error" => "Not Found"}.to_json }
error 422 {|env, exception| exception.as(Realworld::UnprocessableEntityException).content }

Kemal.run
