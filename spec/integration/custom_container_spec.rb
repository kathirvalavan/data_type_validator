require 'spec_helper'
require 'common_helper'
include DataTypeValidator::Constants
include CommonHelper

RSpec.describe DataTypeValidator::CustomContainer do
  it 'should validate for basic datatypes string, float, integer, boolean' do
    custom_container = Class.new(DataTypeValidator::CustomContainer) do
      attribute_def :string_attr, :string
      attribute_def :integer_attr, :integer
      attribute_def :float_attr,   :float
      attribute_def :boolean_attr, :boolean
    end
    status = true
    begin
      custom_container.validate({
        string_attr: get_sample_value(:string),
        integer_attr: get_sample_value(:integer),
        float_attr: get_sample_value(:float),
        boolean_attr: get_sample_value(:boolean),
      })
    rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
      status = false
    end
    expect(status).to eq true

    status = true
    valid_data = {
      string_attr: get_sample_value(:string),
      integer_attr: get_sample_value(:integer),
      float_attr: get_sample_value(:float),
      boolean_attr: get_sample_value(:boolean),
    }
     begin

     [[:string_attr, :integer], [:integer_attr, :float],
     [:float_attr, :float], [:boolean_attr, :string_attr]].each do |shifter|
        test_data = valid_data.dup
        test_data[shifter[0]] = get_sample_value(shifter[1])
        custom_container.validate(test_data)
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq false
    end
  end

  it 'should validate for array of basic datatypes string, float, integer, boolean' do
    custom_container = Class.new(DataTypeValidator::CustomContainer) do
      array_attribute_def :string_attr, :string
      array_attribute_def :integer_attr, :integer
      array_attribute_def :float_attr,   :float
      array_attribute_def :boolean_attr, :boolean
    end
    valid_data = {
      string_attr:  [get_sample_value(:string), get_sample_value(:string)],
      integer_attr: [get_sample_value(:integer), get_sample_value(:integer)],
      float_attr:   [get_sample_value(:float), get_sample_value(:float)],
      boolean_attr: [get_sample_value(:boolean), get_sample_value(:boolean)],
    }

    status = true
    begin
      custom_container.validate(valid_data)
    rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
      status = false
    end
    expect(status).to eq true

    status = true
    [[:string_attr, :integer], [:integer_attr, :float],
    [:float_attr, :float], [:boolean_attr, :string_attr]].each do |shifter|
       test_data = valid_data.dup
       test_data[shifter[0]] << get_sample_value(shifter[1])
       custom_container.validate(test_data)
     rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
       status = false
     end
     expect(status).to eq false

  end

  it 'should validate for custom container of basic datatypes string, float, integer, boolean' do

    custom_container = Class.new(DataTypeValidator::CustomContainer) do
      attribute_def :string_attr, :string
      attribute_def :integer_attr, :integer
      attribute_def :float_attr,   :float
      attribute_def :boolean_attr, :boolean
    end

    nested_container = Class.new(DataTypeValidator::CustomContainer) do
      attribute_def :string_attr, :string
      attribute_def :integer_attr, :integer
      attribute_def :float_attr,   :float
      attribute_def :boolean_attr, :boolean
      attribute_def :custom_attr, custom_container.type_alias
    end

    valid_data = {
      string_attr: get_sample_value(:string),
      integer_attr: get_sample_value(:integer),
      float_attr: get_sample_value(:float),
      boolean_attr: get_sample_value(:boolean),
      custom_attr: {
        string_attr: get_sample_value(:string),
        integer_attr: get_sample_value(:integer),
        float_attr: get_sample_value(:float),
        boolean_attr: get_sample_value(:boolean),
      }
    }

    status = true
    begin
      nested_container.validate(valid_data)
    rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
      puts e.message
      status = false
    end
    expect(status).to eq true

    [[:string_attr, :integer], [:integer_attr, :float],
    [:float_attr, :float], [:boolean_attr, :string_attr]].each do |shifter|
       test_data = valid_data.dup
       test_data = test_data[:custom_attr]
       test_data[shifter[0]] = get_sample_value(shifter[1])
       custom_container.validate(test_data)
     rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
       status = false
     end
     expect(status).to eq false
  end

  it 'should validate for array custom container of basic datatypes string, float, integer, boolean' do
    custom_container = Class.new(DataTypeValidator::CustomContainer) do
      array_attribute_def :string_attr, :string
      array_attribute_def :integer_attr, :integer
      array_attribute_def :float_attr,   :float
      array_attribute_def :boolean_attr, :boolean
    end

    nested_container = Class.new(DataTypeValidator::CustomContainer) do
      array_attribute_def :custom_attr, custom_container.type_alias
    end

    valid_data = {
      string_attr:  [get_sample_value(:string), get_sample_value(:string)],
      integer_attr: [get_sample_value(:integer), get_sample_value(:integer)],
      float_attr:   [get_sample_value(:float), get_sample_value(:float)],
      boolean_attr: [get_sample_value(:boolean), get_sample_value(:boolean)],
    }

    test_data = {
      custom_attr: [valid_data, valid_data, valid_data]
    }

    status = true
    begin
      custom_container.validate(valid_data)
    rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
      status = false
    end
    expect(status).to eq true
    # todo - negative cases pending
  end

end
