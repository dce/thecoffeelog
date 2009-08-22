class Feed < ActiveRecord::Base
  validates_presence_of :url

  before_create :set_feed_title

  def url_from_user=(user_url)
    feeds = Feedbag.find(user_url)
    self.url = feeds.first
    self.errors.add :url, "contains no feeds"
  end

  def set_feed_title
    self.title = FeedTools::Feed.open(self.url).title
  end
end
