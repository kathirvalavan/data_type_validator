# data_type_validator
Simple DSL for datatype validation for basic data types.
Inspired from [GRPC DSL](https://developers.google.com/protocol-buffers/docs/proto3).
The purpose of this library is strictly not for application validations like email, pattern matching. This is purely for datatype matching. Since ruby is dynamic language, usecases where strict datatypes should be enforced this library will be helpful.  

# installation

`gem install data_type_validator`

# Usage

# Structure Definition

```
class Custom < DataTypeValidator::CustomContainer
   attribute_def :string_attr,  :string
   attribute_def :integer_attr, :integer
   attribute_def :float_attr,   :float
   attribute_def :boolean_attr, :boolean
end

```

# Validations

###### return true if valid
###### throws exception DataTypeValidator::Errors::InvalidTypeDefinitions if invalid

```
  Custom.validate({ string_attr: "1", integer_attr: 1, float_attr: 1.21, boolean_attr: true })
```

# attribute_def

```
  > attribute_def :name(attribute key), :type(data_type)
  > valid types are :string, :integer, :float, :boolean, DataTypeValidator::CustomContainer
```

# Array attribute Definition

```
class Custom < DataTypeValidator::CustomContainer
     array_attribute_def :array_attr, :string
end
```

### invocation
```
  Custom.validate({ array_attr: ["1", "2"] })
```

# Nested hash attribute definition

```
class NestedCustom < DataTypeValidator::CustomContainer
  attribute_def :string_attr, :string
end

class Custom < DataTypeValidator::CustomContainer
  attribute_def       :nested_attr, NestedCustom.type_alias
  array_attribute_def :array_attr, :string
end

```

### invocation

```
  Custom.validate({ array_attr: ["1", "2"], nested_attr: { string_attr: "1" } })  
```

### NOTES
1. Does not support inheritance. always inherit from DataTypeValidator::CustomContainer.
2. The purpose of this library is only type validation. We intended to avoid
multilevel inheritance, other complex patterns.
3. We follow GRPC DSL. Neat and clean.
