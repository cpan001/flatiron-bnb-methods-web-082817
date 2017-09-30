require_relative "./listing.rb"
class MyValidator < ActiveModel::Validator

  def validate(record)
    if record.checkin && record.checkout
      checkin_check(record)
      listing_availability_check(record)
      id_check(record)
    end
  end

  private

  def checkin_check(record)
    if record.checkin >= record.checkout
      record.errors.add(:checkin, "Checkin must be before checkout")
    end
  end

  def listing_availability_check(record)
    if !record.listing.listing_open?(record.checkin, record.checkout)
      record.errors.add(:checkin, "Listing not available for checkin")
    end
  end

  def id_check(record)
    if record.listing.host_id == record.guest_id
      record.errors.add(:guest_id, "Cannot make a reservation on your own listing")
    end
  end


end
