# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/config/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each { |f| require f }
