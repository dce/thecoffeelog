class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed

  validates_presence_of :user
  validates_presence_of :feed

  before_create :set_title
  
  def self.create_from_email_message(from, body)
    urls = body.split(/\n/)
    success, failure = urls.map {|u| Feed.for(u) }.partition {|f| f.valid? }
    
    user = User.find_or_create_by_email(from)
    user.feeds << success

    if user.active?
      FeedMailer.deliver_subscription_results(user, success, failure)
    else
      FeedMailer.deliver_activation_email(user, success, failure)
    end
  end

  private

  def set_title
    self.title = self.feed.title if self.feed
  end
end
