Factory.define :feed do |f|
  f.url "http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml"
  f.title "NY Times"
  f.last_checked_at Time.now
end
