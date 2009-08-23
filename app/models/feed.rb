class Feed < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, :through => :subscriptions
  has_many :entries

  validate :valid_url_from_user?
  validates_presence_of :url

  before_create :set_feed_title

  attr_accessor :unverified_url, :verified_url

  named_scope :with_entries, :joins => :entries, :group => "entries.feed_id"

  def self.for(url)
    feed_url = Feedbag.find(url).first
    find_or_create_by_url(feed_url) if feed_url
  end

  def self.create_by_user_url(url)
    feed_url = Feedbag.find(url).first
    feed = find_by_url(feed_url) if feed_url
    feed || create(:unverified_url => url, :verified_url => feed_url)
  end

  def fetch_updates(limit = nil)
    items = new_entries
    items = items.first(limit) if limit

    if items.any?
      items.map(&:save)
      items.first.mark_as_last_sent
    end
  end

  private

  def valid_url_from_user?
    if unverified_url.present?
      self.url = verified_url

      unless self.url
        self.errors.add(:url, "contains no feeds")
        self.url = unverified_url
      end
    end
  end

  def verified_url
    @verified_url ||= Feedbag.find(unverified_url).first
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
