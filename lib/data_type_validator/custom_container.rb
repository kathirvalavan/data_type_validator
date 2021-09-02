require 'active_support/core_ext/class/attribute'
module DataTypeValidator
  class CustomContainer

    class_attribute :attributes

    def self.attribute_definition(attr, type, options: {})
      self.attributes = {} if self.attributes.nil?
      self.attributes[attr] = { type: type, options: {}, attr: attr }
    end

    def self.array_attribute_definition(attr, type, options: {})
      self.attributes = {} if self.attributes.nil?
      self.attributes[attr] = { type: DataTypeValidator::Constants::ARRAY_TYPE, sub_type: type, options: {}, attr: attr }
    end

    def self.type_alias
      @type_alias_instance ||= new
    end


    def validate(data)
      validate_data_store(data)
      return true
    end

    private

      def validate_data_store(data_store)
        self.class.attributes.each do |attr, definition|
          DataTypeValidator::Validator.validate(definition[:type], data_store[attr], definition)
        end
      end

  end

end
