require "securerandom"

class ShortenedUrl < ApplicationRecord
    validates :long_url, presence: true 
    validates :user_id, presence: true


    def self.random_code 
        gen = SecureRandom.urlsafe_base64 
        until !ShortenedUrl.exists?(short_url: gen)
            gen = SecureRandom.urlsafe_base64 
        end
        gen
    end

    def self.new_shortened_url(submitter, original_url)
        short = ShortenedUrl.random_code
        s = ShortenedUrl.new(short_url: short, long_url: original_url, user_id: User.find_by(email: submitter).id)
        s.save
    end

    belongs_to :submitter,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id

    has_many :visits,
        class_name: :Visit,
        primary_key: :id,
        foreign_key: :shorten_url_id

    # has_many :visitors, 
    #     through: :visits,
    #     source: :visitor

    has_many :visitors,
        Proc.new { distinct }, #<<<
        through: :visits,
        source: :visitor

    def num_clicks
        self.visits.length
    end

    def num_uniques
        self.visitors.length
    end

    def num_recent_uniques
        self.visits.map {|v| v.created_at > 1.minutes.ago}
    end

end