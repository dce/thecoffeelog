require 'tmail'
 
class EmailProcessor
  attr_accessor :user, :options
 
  def self.process(*args)
    email_processor = new(*args)
    email_processor.do_stuff
  end
 
  def find_user
    logger.info("Finding user: #{@options[:from]}")
    @user = User.find_or_create_user_by_email(:email => @options[:from]})
  end
 
  def do_stuff
		logger.info("Processing message.")
  end
 
  def initialize(*args)
    @options = args.extract_options!
    find_user
  end
end