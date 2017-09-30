class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :title, :description, :address, :listing_type, :price, :neighborhood_id, presence: true

  after_create :change_host_to_true
  after_destroy :change_host_status

  def change_host_to_true
    host = self.host
    host.host = true
    host.save
  end

  def change_host_status
    if self.host.listings.empty?
      host.host = false
      host.save
    end
  end

  def average_review_rating
    size = self.reviews.size.to_f
    if size > 0
      self.reviews.inject(0) do |sum, review|
        sum += review.rating if review.rating
      end / size
    else
      0
    end
  end

  #for a listing
  def listing_open?(date1, date2)
    self.reservations.all? do |res|
      (res.checkin < date1 && res.checkout < date1) || (res.checkin > date2 && res.checkout > date2)
    end
  end

end
