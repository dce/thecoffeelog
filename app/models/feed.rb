class Feed < ActiveRecord::Base
  validates_presence_of :url
  
  def url_from_user=(user_url)
    feeds = Feedbag.find(user_url)
    self.url = feeds.first
    self.errors.add :url, "contains no feeds"
  end
end
