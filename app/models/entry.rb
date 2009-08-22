require 'digest/md5'

class Entry < ActiveRecord::Base
  belongs_to :feed

  validates_presence_of :title, :link, :unique_key, :published_at, :feed
  validates_uniqueness_of :unique_key

  before_validation_on_create :generate_unique_key

  def self.from_feedtools(entry)
    new(
      :title        => entry.title,
      :link         => entry.link,
      :author       => entry.author.try(:name),
      :published_at => entry.published,
      :content      => entry.content
    )
  end

  private

  def generate_unique_key
    key_identifiers = "#{self.feed.try :title} #{self.title} #{self.link}"
    self.unique_key ||= Digest::MD5.hexdigest(key_identifiers)
  end
end