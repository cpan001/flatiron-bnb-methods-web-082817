require_relative "./listing.rb"
require 'date'
require 'pry'
module Calculation

  module InstanceMethods
    def city_openings(date1, date2)
      date1 = DateTime.parse(date1)
      date2 = DateTime.parse(date2)
      self.listings.select do |listing|
        listing.listing_open?(date1, date2)
      end
    end

    def neighborhood_openings(date1, date2)
      date1 = DateTime.parse(date1)
      date2 = DateTime.parse(date2)
      self.listings.select do |listing|
        listing.listing_open?(date1, date2)
      end
    end

    def number_of_res_per_area
      count = 0
      self.listings.each do |listing|
        count += listing.reservations.size
      end
      count
    end

  end

  module ClassMethods
    def highest_ratio_res_to_listings
      areas = self.all
      areas.max_by do |area|
        num_of_listings = area.listings.size
        num_of_reservations = area.number_of_res_per_area
        num_of_listings == 0 ? 0 : (num_of_reservations / num_of_listings )
      end

    end

    def most_res
      self.all.max_by do |area|
        area.number_of_res_per_area
      end
    end
  end

end
