class AddLastSentEntryHashToFeed < ActiveRecord::Migration
  def self.up
    add_column :feeds, :last_sent_entry_hash, :string
  end

  def self.down
    remove_column :feeds, :last_sent_entry_hash
  end
end
