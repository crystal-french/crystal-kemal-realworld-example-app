require "json"

module Realworld::Actions
  class Base

    def parse_json_body(body)
      begin
        JSON.parse(body.not_nil!)
      rescue exception
        {} of String => JSON::Any
      end
    end

  end
end