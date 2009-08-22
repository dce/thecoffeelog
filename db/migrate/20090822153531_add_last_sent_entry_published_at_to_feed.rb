class AddLastSentEntryPublishedAtToFeed < ActiveRecord::Migration
  def self.up
    add_column :feeds, :last_sent_entry_published_at, :datetime
  end

  def self.down
    remove_column :feeds, :last_sent_entry_published_at, :datetime
  end
end
