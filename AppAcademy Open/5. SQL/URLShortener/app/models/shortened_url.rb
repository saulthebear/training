# == Schema Information
#
# Table name: shortened_urls
#
#  id           :bigint           not null, primary key
#  long_url     :string           not null
#  short_url    :string           not null
#  submitter_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true, uniqueness: true
  validates :short_url, uniqueness: true
  validate :no_spamming

  belongs_to :submitter, class_name: 'User', foreign_key: :submitter_id
  has_many :visits, class_name: :Visit, foreign_key: :url_id, primary_key: :id
  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor

  def self.random_code
    candidate_code = nil
    while candidate_code.nil? || exists?({short_url: candidate_code})
      candidate_code = SecureRandom.urlsafe_base64
    end
    candidate_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    create!({
      long_url: long_url,
      short_url: random_code,
      submitter_id: user.id
    })
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visitors.where("visits.created_at > ?", 10.minutes.ago).count
  end

  def no_spamming
    num_recent_urls_added = ShortenedUrl.where('submitter_id = ?', submitter_id).where('created_at > ?', 10.minutes.ago).count
    errors[:spam] << 'can\'t add more than 5 URLs in a minute' if num_recent_urls_added >= 5
  end
end
