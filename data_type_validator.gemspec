Gem::Specification.new do |s|
  s.name        = 'data_type_validator'
  s.version     = '1.0'
  s.date        = '2021-08-02'
  s.summary     = "Simple DSL for datatype validation for basic data types.Inspired from GRPC DSL"
  s.description = "Simple DSL for datatype validation for basic data types.Inspired from GRPC DSL. Since ruby is dynamic language, datatype validator helps to reduce runtime errors by validating structure before processing"
  s.authors     = ["kathir"]
  s.email       = 'kathirvalavan.ict@gmail.com'
  s.files       = ["lib/data_type_validator.rb"]
  s.homepage    =
      'https://rubygems.org/gems/data_type_validator'
  s.license       = 'MIT'
  s.metadata    = { "source_code_uri" => "https://github.com/kathirvalavan/data_type_validator" }
  s.required_ruby_version = ">= 2.3"
  gem.add_runtime_dependency(%q<activesupport>, [">= 4.2"])
  s.add_development_dependency "bundler", "~> 1.17"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"
end
