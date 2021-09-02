module DataTypeValidator
  module Errors
    InvalidValueType = Class.new(StandardError)
    InvalidTypeDefinitions = Class.new(StandardError)
  end
end
