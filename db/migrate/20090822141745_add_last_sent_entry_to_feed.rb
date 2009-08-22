class AddLastSentEntryToFeed < ActiveRecord::Migration
  def self.up
    add_column :feeds, :last_sent_entry_id, :string
  end

  def self.down
    remove_column :feeds, :last_sent_entry_id
  end
end
