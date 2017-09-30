class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :rating, :description, :reservation_id, presence: true
  validate :status_is_accepted, :checkout_has_happened

  def status_is_accepted
    if self.reservation
      if self.reservation.status != "accepted"
        errors.add(:reservation_id, "Review only for reservations that are accepted")
      end
    end
  end

  def checkout_has_happened
    if self.reservation
      if self.reservation.checkout > Date.today
        errors.add(:reservation_id, "Review only for reservations that have checkedout")
      end
    end
  end

end
