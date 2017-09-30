require_relative "./calculation_module.rb"

class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  extend Calculation::ClassMethods
  include Calculation::InstanceMethods


end
