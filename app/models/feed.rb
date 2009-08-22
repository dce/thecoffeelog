class Feed < ActiveRecord::Base
  validate :valid_url_from_user?
  validates_presence_of :url

  has_many :subscriptions
  has_many :users, :through => "subscriptions"

  attr_accessor :url_from_user

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
end
