class AddPublishedAtToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :published_at, :datetime
  end

  def self.down
    remove_column :entries, :published_at
  end
end
