require 'spec_helper'
include DataTypeValidator::Constants

RSpec.describe DataTypeValidator::CustomContainer do
  let(:custom_container) do

    Class.new(DataTypeValidator::CustomContainer) do
        attribute_def :string_attr, :string
        attribute_def :integer_attr, :integer
        attribute_def :float_attr,   :float
        attribute_def :boolean_attr, :boolean
        attribute_def :custom_attr, Class.new(DataTypeValidator::CustomContainer).type_alias
        array_attribute_def :array_attr, :string
    end
  end

  it 'should store all definitions in attributes' do
    attr_data = custom_container.attributes
    [:string_attr, :integer_attr, :float_attr,
     :boolean_attr, :custom_attr, :array_attr].each do |attr|
      expect(attr_data[attr].nil?).to eq false
    end
  end

  it 'should define subtype for array' do
    attr_data = custom_container.attributes
    expect(attr_data[:array_attr][:sub_type]).to eq :string
  end

end
