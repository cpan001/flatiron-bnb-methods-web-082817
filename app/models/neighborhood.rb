require_relative "./calculation_module"
class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  extend Calculation::ClassMethods
  include Calculation::InstanceMethods

end
