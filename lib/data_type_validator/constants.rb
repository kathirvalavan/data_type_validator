module DataTypeValidator
  module Constants
    STRING_TYPE = :string.freeze
    BOOLEAN_TYPE = :boolean.freeze
    FLOAT_TYPE   = :float.freeze
    INTEGER_TYPE =  :integer.freeze
    ARRAY_TYPE =  :array.freeze
    CUSTOM_CONTAINER_TYPE = CustomContainer

    DATA_TYPES = [ STRING_TYPE, BOOLEAN_TYPE, FLOAT_TYPE,
      INTEGER_TYPE, CUSTOM_CONTAINER_TYPE ].freeze

  end
end
