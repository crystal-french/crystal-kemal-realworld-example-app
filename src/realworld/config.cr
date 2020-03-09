require "kemal"

Kemal.config.env  = ENV["KEMAL_ENV"]?  || "development"
Kemal.config.port = ENV["KEMAL_PORT"]?.try(&.to_i) || 3000
Kemal.config.host_binding = ENV["KEMAL_HOST"]? || "0.0.0.0"
