class Feed < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, :through => :subscriptions
  has_many :entries

  validate :valid_url_from_user?
  validates_presence_of :url

  before_create :set_feed_title

  attr_accessor :url_from_user

  def self.for(url)
    feed_url = Feedbag.find(url).first
    find_or_create_by_url(feed_url) if feed_url
  end

  def fetch_updates(limit = nil)
    all_entries = feed_data.entries.map {|d| self.entries.from_feedtools(d) }

    last_sent = all_entries.detect do |e|
      e.generate_unique_key == self.last_sent_entry_hash
    end

    new_entries = if last_sent
      all_entries[0, all_entries.index(last_sent)]
    else
      all_entries.select {|e| e.published_at > self. last_sent_entry_published_at }
    end

    new_entries = new_entries[0, limit] if limit

    if new_entries.any?
      new_entries.map(&:save)
      new_entries.first.mark_as_last_sent
    end
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

  def feed_data
    @feed_data ||= FeedTools::Feed.open(self.url)
  end

  def set_feed_title
    self.title ||= feed_data.title
  end
end
