require 'tmail'
 
class EmailProcessor
  attr_accessor :user, :options
 
  def self.process(*args)
    email_processor = new(*args)
    email_processor.do_stuff
  end
 
  def find_user
    @user = User.find(:first, :conditions => {:reception_email => @options[:to]})
  end
 
  def do_stuff
		logger.debug("got message")
  end
 
  def initialize(*args)
    @options = args.extract_options!
    find_user
  end
end