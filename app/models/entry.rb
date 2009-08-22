require 'digest/md5'

class Entry < ActiveRecord::Base
  belongs_to :feed

  validates_presence_of :title, :link, :unique_key, :feed
  validates_uniqueness_of :unique_key

  before_validation_on_create :generate_unique_key

  private

  def generate_unique_key
    key_identifiers = "#{self.feed.try :title} #{self.title} #{self.link}"
    self.unique_key ||= Digest::MD5.hexdigest(key_identifiers)
  end
end