Factory.define :entry do |f|
  f.title "Man On The Moon"
  f.link "http://www.nytimes.com/man-on-moon"
  f.published_at Time.now
  f.content "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  f.author "David Eisinger"
  f.association :feed
end
