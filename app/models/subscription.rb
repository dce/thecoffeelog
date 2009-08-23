class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed

  validates_presence_of :user
  validates_presence_of :feed
  validates_uniqueness_of :feed_id, :scope => :user_id

  before_create :set_title

  def self.create_from_email_message(from, body)
    urls = body.scan(/(^((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix)
    success, failure = urls.map {|u| Feed.for(u.first) }.partition {|f| f.valid? }

    user = User.find_or_create_by_email(from)
    success.each do |feed|
      Subscription.create(:user => user, :feed => feed)
    end

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
