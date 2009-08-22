#!/usr/bin/env ruby
require 'rubygems'
require 'tmail'
require 'beanstalk-client'
 
message = $stdin.read
mail = TMail::Mail.parse(message)

if !mail.to.nil?
  BEANSTALK = Beanstalk::Pool.new(['127.0.0.1:11300'])
  BEANSTALK.yput({:type => 'received_email', 
    :from => mail.from, 
    :subject => mail.subject,
    :body => mail.body})
end