class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true
  
  def self.random_code
    url = nil

    loop do
      url = SecureRandom.urlsafe_base64(16)
      break unless self.exists?(short_url: url)
    end

    url
  end

  def self.generate_short_url(user, long_url)
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
    Visit.where({ shortened_url_id: @id }).select(:user_id).distinct.count
    # visitors.distinct.count
  end

  def num_recent_uniques
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: "Visit"
  
  has_many :visitors,
    through: :visits,
    source: :visitor
end