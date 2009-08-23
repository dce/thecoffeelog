class Feed < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, :through => :subscriptions
  has_many :entries

  validate :valid_url_from_user?
  validates_presence_of :url

  before_create :set_feed_title

  attr_accessor :url_from_user

  named_scope :with_entries, :joins => :entries, :group => "entries.feed_id"

  def self.for(url)
    feed_url = Feedbag.find(url).first
    find_or_create_by_url(feed_url) if feed_url
  end

  def fetch_updates(limit = nil)
    items = new_entries
    items = items.first(limit) if limit

    if items.any?
      items.map(&:save)
      items.first.mark_as_last_sent
    end
  end
  
  def most_recent_items
    feed_data.first(3).map {|i| self.entries.from_feedtools(i) }
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

  def new_entries
    all_entries = feed_data.entries.map {|d| self.entries.from_feedtools(d) }

    last_sent = all_entries.detect do |e|
      e.generate_unique_key == self.last_sent_entry_hash
    end

    if last_sent
      all_entries[0, all_entries.index(last_sent)]
    else
      all_entries.select do |e|
        self.last_sent_entry_published_at.nil? or
        e.published_at > self.last_sent_entry_published_at
      end
    end
  end
end
