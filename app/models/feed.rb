class Feed < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, :through => :subscriptions

  validate :valid_url_from_user?
  validates_presence_of :url

  before_create :set_feed_title

  attr_accessor :url_from_user

  def self.for(url)
    feed_url = Feedbag.find(url).first
    find_or_create_by_url(feed_url) if feed_url
  end

  private

  def valid_url_from_user?
    if url_from_user
      feeds = Feedbag.find(url_from_user)

      self.url = if feeds.any?
        feeds.first
      else
        self.errors.add(:url, "contains no feeds")
        url_from_user
      end
    end
  end

  def set_feed_title
    self.title = FeedTools::Feed.open(self.url).title
  end
end
