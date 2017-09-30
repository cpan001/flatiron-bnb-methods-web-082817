require_relative "./myvalidator.rb"
class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review
  has_one :host, through: :listing

  validates :checkin, :checkout, presence: true

  include ActiveModel::Validations
  validates_with MyValidator

  def duration
    self.checkout - self.checkin
  end

  def total_price
    duration * self.listing.price
  end


end
