require 'rubygems'
require 'daemons'
require File.join(File.dirname(__FILE__), 'daemons_extension')
 
ENV['RAILS_ENV'] ||= 'development'
 
options = {
  :app_name  => 'mail_queue_processor',
  :dir_mode  => :script,
  :dir       => '../log',
  :backtrace => true,
  :mode      => :load,
  :monitor   => true
}
 
Daemons.run(File.join(File.dirname(__FILE__), 'mail_queue_processor.rb'), options)