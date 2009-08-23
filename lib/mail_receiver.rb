#!/usr/bin/env ruby
require 'rubygems'
require 'tmail'
require 'beanstalk-client'
 
message = $stdin.read
mail = TMail::Mail.parse(message)

`echo "Received new mail: #{mail}" >> /var/www/thecoffeelog/shared/log/production.log`

if !mail.to.nil?
  BEANSTALK = Beanstalk::Pool.new(['127.0.0.1:11300'])
  BEANSTALK.yput({:type => 'received_email', 
    :from => mail.from.to_s, 
    :subject => mail.subject.to_s,
    :body => mail.body.to_s})
end