#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require 'rubygems'
require 'beanstalk-client'
require 'yaml'
 
@logger = Logger.new("#{RAILS_ROOT}/log/queue.#{Rails.env}.log")
@logger.level = Logger::INFO

@logger.info("Starting daemon")

BEANSTALK = Beanstalk::Pool.new(['127.0.0.1:11300'])

loop do
  job = BEANSTALK.reserve
  job_hash = job.ybody
  @logger.info("Recieved job #{job_hash}")
  case job_hash[:type]
  when 'received_email'
    @logger.info("Got email: #{job_hash.inspect}")
    if EmailProcessor.process(job_hash)
      job.delete
    else
      @logger.warn("Did not process email: #{job_hash.inspect}")
      job.bury
    end
  else
    @logger.warn("Don't know how to process #{job_hash.inspect}")
  end
end
