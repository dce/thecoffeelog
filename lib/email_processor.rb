require 'tmail'
 
class EmailProcessor
  attr_accessor :user, :options
 
  def self.process(*args)
    email_processor = new(*args)
    email_processor.do_stuff
  end
 
  def find_user
    Rails.logger.info("Finding user: #{@options[:from]}")
    @user = User.find_or_create_by_email(@options[:from])
    Rails.logger.flush
  end
 
  def do_stuff
		Rails.logger.info("Processing message.") #TODO: create subscription
		Rails.logger.flush
  end
 
  def initialize(*args)
    @options = args.extract_options!
    find_user
  end
end