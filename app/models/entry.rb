class Entry < ActiveRecord::Base
  validates_presence_of :title, :link, :unique_key, :feed_id
  validates_uniqueness_of :unique_key

end
