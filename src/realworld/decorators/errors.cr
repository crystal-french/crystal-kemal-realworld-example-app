require "json"

module Realworld::Decorators
  class Errors
    def initialize(errors : Array(Hash(Symbol, String)))
      @errors = errors.reduce({} of String => Array(String)) do |memo, error|
        memo[error[:field]] = memo[error[:field]]? || [] of String
        memo[error[:field]] << error[:message]
        memo
      end
    end

    def initialize(@errors : Hash(String, Array(String)))
    end

    def to_json(builder : JSON::Builder)
      builder.object do
        @errors.each do |key, value|
          builder.field(key) do
            builder.array do
              value.each { |v| builder.string(v) }
            end
          end
        end
      end
    end

  end
end