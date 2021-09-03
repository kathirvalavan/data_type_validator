require 'active_support/core_ext/class/attribute'
module DataTypeValidator
  class CustomContainer

    class_attribute :attributes

    #  Add attributes for type definition. Supported for basic types and hashtype.
    #  => for array we have separate function array_attribute_def
    #  @param attr [Symbol] key in the datastruture
    #  @param type [Symbol] type of attr value in the datastruture
    #  === Examples
    #   class Custom < DataTypeValidator::CustomContainer
    #     attribute_def :string_attr, :string
    #     attribute_def :integer_attr, :integer
    #     attribute_def :float_attr,   :float
    #     attribute_def :boolean_attr, :boolean
    #     attribute_def :custom_attr, NestedCustom.type_alias
    #   end
    #   class NestedCustom < DataTypeValidator::CustomContainer
    #   end

    def self.attribute_def(attr, type, options: {})
      self.attributes = {} if self.attributes.nil?
      self.attributes[attr] = { type: type, options: {}, attr: attr }
    end

    #  Add attributes for array datastruture
    #  @param attr [Symbol] key in the datastruture
    #  @param type [Symbol] type of attr item value in the datastruture
    #  === Examples
    #   class Custom < DataTypeValidator::CustomContainer
    #     array_attribute_def :array_attr, :string
    #   end

    def self.array_attribute_def(attr, type, options: {})
      self.attributes = {} if self.attributes.nil?
      self.attributes[attr] = { type: DataTypeValidator::Constants::ARRAY_TYPE, sub_type: type, options: {}, attr: attr }
    end

    # Alias for Custom container. Intention is to have type alias for our custom container class
    def self.type_alias
      @type_alias_instance ||= new
    end

    #  Validate given data hash with the dsl definitions
    #  @param data [Hash] hash data to be validated
    #  @return [bool]
    #  return true if data is valid with the type definition dsl
    #  raise DataTypeValidator::Errors::InvalidTypeDefinitions if data is invalid
    #  === Examples
    #   class Custom < DataTypeValidator::CustomContainer
    #     array_attribute_def :array_attr, :string
    #   end
    #   Custom.validate({ array_attr: ["1", "2"] })

    def self.validate(data)
      new.validate(data)
    end

    def validate(data)
      validate_data_store(data)
      return true
    end

    private

      def validate_data_store(data_store)
        (self.class.attributes || {}).each do |attr, definition|
          DataTypeValidator::Validator.validate(definition[:type], data_store[attr], definition)
        end
      end

  end

end
