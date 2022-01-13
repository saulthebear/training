# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

premium_users = User.create!([
  { email: 'stefanvosloo1@gmail.com', premium: true },
  { email: 'ned@appacademny.io', premium: true },
  { email: 'george@ef.com', premium: true },
  { email: 'ned@flanders.guru', premium: true }
])

free_users = User.create!([
  { email: 'spamstefanplease@gmail.com' },
  { email: 'danielleshelan@gmail.com' }
])

all_users = premium_users + free_users

long_urls = %w[
  google.com
  facebook.com
  myspace.com
  news.google.com
  hellofresh.com
  bbc.com
  sports.bbc.com
  weather.com
  genius.com
  reddit.com
  skynews.com
  youtube.com
]

long_urls.each do |long_url|
  ShortenedUrl.create_for_user_and_long_url!(premium_users.sample, long_url)
end

topics = TagTopic.create!([
  { name: 'Social Media' },
  { name: 'News' },
  { name: 'Sports' },
  { name: 'Music' }
])
sm = TagTopic.find_by(name: 'Social Media')
news = TagTopic.find_by(name: 'News')
sports = TagTopic.find_by(name: 'Sports')
music = TagTopic.find_by(name: 'Music')

Tagging.add_tagging!(ShortenedUrl.find_by(long_url: 'facebook.com'), sm)
Tagging.add_tagging!(ShortenedUrl.find_by(long_url: 'myspace.com'), sm)
Tagging.add_tagging!(ShortenedUrl.find_by(long_url: 'reddit.com'), sm)
Tagging.add_tagging!(ShortenedUrl.find_by(long_url: 'youtube.com'), sm)
Tagging.add_tagging!(ShortenedUrl.find_by(long_url: 'genius.com'), music)
Tagging.add_tagging!(ShortenedUrl.find_by(long_url: 'news.google.com'), news)
Tagging.add_tagging!(ShortenedUrl.find_by(long_url: 'bbc.com'), news)
Tagging.add_tagging!(ShortenedUrl.find_by(long_url: 'sports.bbc.com'), sports)

short_urls = ShortenedUrl.all

short_urls.each do |short_url|
  rand(1..10).times { Visit.record_visit!(all_users.sample, short_url) }
end
