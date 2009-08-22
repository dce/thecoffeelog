Factory.define :subscription do |f|
  f.association :user
  f.association :feed
  f.title "NY Times"
end
