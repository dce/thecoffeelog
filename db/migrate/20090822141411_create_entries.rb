class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :title,        :null =>false
      t.string :link,         :null =>false
      t.text :content
      t.string :unique_key,   :null =>false
      t.string :author
      t.integer :feed_id,     :null =>false

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
