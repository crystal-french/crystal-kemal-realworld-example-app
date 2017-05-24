require "./realworld/*"
require "kemal"

module Realworld
  get "/" do
    "Hello World!"
  end
end

Kemal.run
