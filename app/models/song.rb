class Song < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist
  
  scope :recent, -> (n) { joins(:album).where("albums.released_on >= ?", (Date.today - 6.months)).order("id DESC").limit(n) }
  
  validates :name, presence: true, length: { in: 5..50 }
  validates :album_id, :artist_id, presence: true
end
