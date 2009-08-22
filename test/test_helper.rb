
$:.push(File.dirname(__FILE__))
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'factory_girl'
require 'mocha'
require 'webrat'

Webrat.configure do |config|
  config.mode = :rails
end

class ActiveSupport::TestCase  
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all
end  
