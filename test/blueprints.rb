require 'machinist/active_record'

CreepyCrawler::Website.blueprint do
  name { Faker::Lorem.words(3).join(' ') }
  uri {"http://asdfs.com"} 
  type {"WebbySite"}
end

# Album.blueprint do
#   name { Faker::Lorem.words(3).join(' ') }
#   views { rand(50) }
#   artist { Artist.make! }
# end