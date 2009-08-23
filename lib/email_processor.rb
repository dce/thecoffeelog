require 'tmail'
 
class EmailProcessor
  attr_accessor :options
 
  def self.process(*args)
    email_processor = new(*args)
    email_processor.do_stuff
  end
 
  def do_stuff
		Rails.logger.info("Processing message from: #{@options[:from]}")
		Subscription.create_from_email_message(@options[:from], @options[:body])
		Rails.logger.flush
  end
 
  def initialize(*args)
    @options = args.extract_options!
  end
end