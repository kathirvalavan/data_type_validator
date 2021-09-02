module DataTypeValidator
  class CustomContainer

    class_methods do
      def attribute_definition(attr, type, options: {})
        self.attributes = {} if self.attributes.nil?
        self.attributes[attr] = { type: type, options: {}, attr: attr)
      end

      def array_attribute_definition(attr, type, options)
        self.attributes = {} if self.attributes.nil?
        self.attributes[attr] = { type: ARRAY_TYPE, sub_type: type, options: {}, attr: attr }
      end
    end

    def validate(data)
      validate_data_store(data)
      return true
    end

    private

      def validate_data_store(data_store)
        self.attributes.each do |attr, definition|
          DataTypeValidator.validate(definition[:type], data_store[attr], definition)
        end
      end
  end

end
