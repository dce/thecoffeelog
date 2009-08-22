require 'rubygems'
require 'daemons'
require File.join(File.dirname(__FILE__), 'daemons_extension')
 
ENV['RAILS_ENV'] ||= 'development'
 
options = {
  :app_name  => 'processor',
  :dir_mode  => :script,
  :dir       => '../log',
  :backtrace => true,
  :mode      => :load,
  :monitor   => true
}
 
Daemons.run(File.join(File.dirname(__FILE__), 'processor.rb'), options)