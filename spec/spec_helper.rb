require 'rspec'

require 'mongoid'
require 'mongoid_slug'

Dir['./spec/models/*.rb'].each { |f| require f }

def database_id
  ENV['CI'] ? "mongoid_slug_#{Process.pid}" : 'mongoid_slug_test'
end

Mongoid.configure do |config|
  config.connect_to database_id
end


RSpec.configure do |c|
  c.before(:each) do
    Mongoid.purge!
    Mongoid::IdentityMap.clear
  end

  c.after(:suite) do
    Mongoid::Threaded.sessions[:default].drop if ENV['CI']
  end
end
