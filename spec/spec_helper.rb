require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root + "spec/support/**/*.rb"].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.extend VCR::RSpec::Macros
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.fixture_path = ::Rails.root + "spec/fixtures"
    config.use_transactional_fixtures = true

    load Rails.root + "db/seeds.rb"

    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    config.include Devise::TestHelpers, :type => :controller

    # Render views
    config.render_views
  end
end

Spork.each_run do
  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers

  load Rails.root + "config/routes.rb"
  Dir[ Rails.root + "app/**/*.rb"].each { |f| load f }

end if Spork.using_spork?
