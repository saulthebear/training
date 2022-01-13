class Tagging < ApplicationRecord
  validates :url_id, presence: true
  validates :topic_id, presence: true

  belongs_to :topic,
    class_name: :TagTopic,
    foreign_key: :topic_id,
    primary_key: :id
  
  belongs_to :url,
    class_name: :ShortenedUrl,
    foreign_key: :url_id,
    primary_key: :id

  def self.add_tagging!(shortened_url, tag_topic)
    create!({ url_id: shortened_url.id, topic_id: tag_topic.id })
  end
end
