class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed

  validates_presence_of :user
  validates_presence_of :feed

  before_create :set_title

  private

  def set_title
    self.title = self.feed.title if self.feed
  end
end
