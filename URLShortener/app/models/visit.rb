class Visit < ApplicationRecord 
    validates :user_id, presence: true
    validates :shorten_url_id, presence: true 

    def self.record_visit!(user, shortened_url)
        vis = Visit.new(user_id: user.id, shorten_url_id: shortened_url.id)
        vis.save!
    end

    belongs_to :visitor,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id 

    belongs_to :short_url,
        class_name: :ShortenedUrl,
        primary_key: :id,
        foreign_key: :shorten_url_id 

end