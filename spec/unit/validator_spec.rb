require 'spec_helper'
include DataTypeValidator::Constants
RSpec.describe DataTypeValidator::Validator do
  context 'validate basic datatypes string, integer, boolean, float properly' do
    it "validate String" do
      status = true
      begin
        DataTypeValidator::Validator.validate(STRING_TYPE, 'hello')
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq true

      status = true
      begin
        DataTypeValidator::Validator.validate(STRING_TYPE, 1)
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq false
    end

    it "validate integer" do
      status = true
      begin
        DataTypeValidator::Validator.validate(INTEGER_TYPE, 1)
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq true

      status = true
      begin
        DataTypeValidator::Validator.validate(INTEGER_TYPE, "1")
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq false

    end

    it "validate float" do
      status = true
      begin
        DataTypeValidator::Validator.validate(FLOAT_TYPE, 1.12)
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq true

      status = true
      begin
        DataTypeValidator::Validator.validate(FLOAT_TYPE, "1")
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq false

    end

    it "validate boolean" do
      status = true
      begin
        DataTypeValidator::Validator.validate(BOOLEAN_TYPE, true)
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq true

      status = true
      begin
        DataTypeValidator::Validator.validate(BOOLEAN_TYPE, "1")
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq false

    end
  end

  context 'validate array of basic subtype datatypes string, integer, boolean, float properly' do
    it "validate array String" do
      status = true
      begin
        DataTypeValidator::Validator.validate(ARRAY_TYPE, ['hello', 'hello'], { sub_type: STRING_TYPE })
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq true

      status = true
      begin
        DataTypeValidator::Validator.validate(ARRAY_TYPE, [1, 'hello'], { sub_type: STRING_TYPE })
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq false
    end

    it "validate array integer" do
      status = true
      begin
        DataTypeValidator::Validator.validate(ARRAY_TYPE, [1, 2], { sub_type: INTEGER_TYPE })
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq true

      status = true
      begin
        DataTypeValidator::Validator.validate(ARRAY_TYPE, [1, "1"], { sub_type: INTEGER_TYPE })
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq false

    end

    it "validate array float" do
      status = true
      begin
        DataTypeValidator::Validator.validate(ARRAY_TYPE, [1.12, 2.22], { sub_type: FLOAT_TYPE })
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq true

      status = true
      begin
        DataTypeValidator::Validator.validate(ARRAY_TYPE, ["1", 1.2], { sub_type: FLOAT_TYPE })
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq false

    end

    it "validate array boolean" do
      status = true
      begin
        DataTypeValidator::Validator.validate(ARRAY_TYPE, [true, false], { sub_type: BOOLEAN_TYPE })
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq true

      status = true
      begin
        DataTypeValidator::Validator.validate(ARRAY_TYPE, ["1", true], { sub_type: BOOLEAN_TYPE })
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq false

    end
  end

  context 'validate custom container types DataTypeValidator::CustomContainer' do
    it 'should call validate function' do
      custom = Class.new(DataTypeValidator::CustomContainer)
      status = true
      begin
        DataTypeValidator::Validator.validate(custom.type_alias, {})
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq true
    end
  end

  context 'validate array custom container types DataTypeValidator::CustomContainer' do
    it 'should call validate function' do
      custom = Class.new(DataTypeValidator::CustomContainer)
      status = true
      begin
        DataTypeValidator::Validator.validate(ARRAY_TYPE, [{}, {}] , { sub_type: custom.type_alias })
      rescue DataTypeValidator::Errors::InvalidTypeDefinitions => e
        status = false
      end
      expect(status).to eq true
    end
  end

end
