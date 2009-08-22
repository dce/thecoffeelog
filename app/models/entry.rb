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

  def mark_as_last_sent
    generate_unique_key

    self.feed.update_attributes(
      :last_sent_entry_hash => self.unique_key,
      :last_sent_entry_published_at => self.published_at
    )
  end

  def generate_unique_key
    self.unique_key ||= begin
      key_identifiers = "#{self.feed.try :title} #{self.title} #{self.link}"
      Digest::MD5.hexdigest(key_identifiers)
    end
  end
end