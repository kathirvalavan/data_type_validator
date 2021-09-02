require 'data_type_validator/constants'
require 'data_type_validator/errors'

module DataTypeValidator
  class Validator

    def self.validate(type, value, definition = {})
      raise value.is_a?(String)  raise InvalidTypeDefinitions, "attr=#{definition[:attr]} => #{value}" if value.nil?

      case type
      when STRING_TYPE
        raise InvalidTypeDefinitions, " attr=#{definition[:attr]} => #{value} " unless value.is_a?(String)
      when BOOLEAN_TYPE
        raise InvalidTypeDefinitions, " attr=#{definition[:attr]} => #{value} " unless value.is_a?(TrueClass) || value.is_a?(FalseClass)
      when FLOAT_TYPE
        raise InvalidTypeDefinitions, " attr=#{definition[:attr]} => #{value} " unless value.is_a?(Float)
      when INTEGER_TYPE
        raise InvalidTypeDefinitions, " attr=#{definition[:attr]} => #{value} " unless value.is_a?(Integer)
      when ARRAY_TYPE
        raise InvalidTypeDefinitions, " attr=#{definition[:attr]} => #{value} " unless value.is_a?(Array)
        value.each do |v|
          DataTypeValidator.validate(definition[:sub_type], v, definition)
        end
      when CUSTOM_CONTAINER_TYPE
        raise InvalidTypeDefinitions, " attr=#{definition[:attr]} => #{value} " unless value.is_a?(Hash)
        type.new.validate(value)
      end
    end

  end
end
