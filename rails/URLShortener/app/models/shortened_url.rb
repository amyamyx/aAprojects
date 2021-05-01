# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true
  validate :no_spamming, :nonpremium_max

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: "Visit"
  
  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  has_many :taggings,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: "Tagging"

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic_id

  def self.random_code
    loop do
      url = SecureRandom.urlsafe_base64(16)
      return url unless self.exists?(short_url: url)
    end
  end

  def self.generate_short_url!(user, long_url)
    ShortenedUrl.create!({
      user_id: user.id, 
      long_url: long_url,
      short_url: self.random_code
    })
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits
      .select(:user_id)
      .where("created_at > ?", 10.minutes.ago)
      .distinct
      .count
  end  

  def no_spamming
    num_recent_urls = ShortenedUrl
      .where('created_at >= ?', 1.minutes.ago)
      .where(user_id: self.user_id)
      .count

    if num_recent_urls > 5
      errors[:base] << "Can't submit more than 5 urls within a minute."
    end
  end

  def nonpremium_max
    return if User.find(self.user_id).premium

    num_urls = ShortenedUrl
      .where(user_id: self.user_id)
      .count

    errors[:maximum] << "of 5 urls if not premium" if num_urls > 5
    
  end
end
